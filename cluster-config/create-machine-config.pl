my $fileName = "machine-config-source.yaml";

open InputFileHandle, $fileName;
while (eof(InputFileHandle) == 0)
{
  read InputFileHandle, $dataFromFile, 25;
  $machineConfigSource = join('',$machineConfigSource, $dataFromFile);
}
close InputFileHandle;

$policyJSONDAta = `cat policy.json | python3 -c "import sys, urllib.parse; print(urllib.parse.quote(''.join(sys.stdin.readlines())))"`;
$defaultYAMLData = `cat default.yaml | python3 -c "import sys, urllib.parse; print(urllib.parse.quote(''.join(sys.stdin.readlines())))"`;
$signerKeyPubData = `cat signer-key.pub | python3 -c "import sys, urllib.parse; print(urllib.parse.quote(''.join(sys.stdin.readlines())))"`;

$policyJSONDAta = substr($policyJSONDAta, 0, length($policyJSONDAta) - 1);
$defaultYAMLData = substr($defaultYAMLData, 0, length($defaultYAMLData) - 1);
$signerKeyPubData = substr($signerKeyPubData, 0, length($signerKeyPubData) - 1);

$machineConfigSource =~ s/policy-json-placeholder/$policyJSONDAta/;
$machineConfigSource =~ s/default-yaml-placeholder/$defaultYAMLData/;
$machineConfigSource =~ s/encoded-signer-pub-placeholder/$signerKeyPubData/;

print($machineConfigSource);
