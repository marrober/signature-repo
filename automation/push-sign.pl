$quayAuthFile = "~/Downloads/marrober-quay-io-auth.json";
$signByEmailAddress = "mroberts\@redhat.com";
$quayURL = "quay.io";
$quayRepositoryName = "marrober";


$ocRegistryLoginResult = `oc registry login`;
$buildahLoginResult = `buildah login --authfile $quayAuthFile $quayURL`;
$imageLocationTagInOCP = `oc get is -o jsonpath='{.items[0].status.publicDockerImageRepository}{":"}{.items[0].status.tags[0].tag}'`;
$namespace = `oc get is -o jsonpath='{.items[0].metadata.namespace}'`;

$skopeoCopyCmd = "skopeo copy --sign-by ".$signByEmailAddress." docker://".$imageLocationTagInOCP." docker://".$quayURL."/".$quayRepositoryName."/".$namespace.":latest";
$skopeoCopyResult = `$skopeoCopyCmd`;

$copySignatureToRepo = `cp -R /var/lib/containers/sigstore/marrober/* /home/mark/data/git-repos/signature-repo/images/marrober`;

$gitAddResult = `git add ../.`;
$gitCommitCmd = "git commit -m \"adding signature\"";
$gitCommitResult = `$gitCommitCmd`;
$gitPushResult = `git push`;
