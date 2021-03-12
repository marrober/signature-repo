$quayAuthFile = "~/Downloads/marrober-quay-io-auth.json";
$signByEmailAddress = "mroberts\@redhat.com";
$quayURL = "quay.io";
$quayRepositoryName = "marrober";


$ocRegistryLoginResult = `oc registry login`;
print $ocRegistryLoginResult."\n";
$buildahLoginResult = `buildah login --authfile $quayAuthFile $quayURL`;
print $buildahLoginResult."\n";
$imageLocationTagInOCP = `oc get is -o jsonpath='{.items[0].status.publicDockerImageRepository}{":"}{.items[0].status.tags[0].tag}'`;
print $imageLocationTagInOCP."\n";
$namespace = `oc get is -o jsonpath='{.items[0].metadata.namespace}'`;
print $namespace."\n";

$skopeoCopyCmd = "skopeo copy --sign-by ".$signByEmailAddress." docker://".$imageLocationTagInOCP." docker://".$quayURL."/".$quayRepositoryName."/".$namespace.":latest";
print $skopeoCopyCmd."\n";
$skopeoCopyResult = `$skopeoCopyCmd`;
print $skopeoCopyResult."\n";

$copySignatureToRepo = `cp -R /var/lib/containers/sigstore/marrober/* /home/mark/data/git-repos/signature-repo/images/marrober`;
print $copySignatureToRepo."\n";

$gitAddResult = `git add ../.`;
print $gitAddResult."\n";
$gitCommitCmd = "git commit -m \"adding signature\"";
$gitCommitResult = `$gitCommitCmd`;
print $gitCommitResult."\n";
$gitPushResult = `git push`;
print $gitCommitResult."\n";
