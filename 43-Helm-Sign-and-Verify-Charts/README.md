# Helm Charts Sign and Verify

## Step-01: Introduction
- [GnuPG](https://gnupg.org/)
- Generating Private/Public Keys with gpg
- Sign the Helm Package 
- Export public key
- Verify Helm Package using Public Key

## Step-02: Install gnupg 
### Step-02-01: Install gnupg on MacOS
- [Install gnupg using homebrew](https://formulae.brew.sh/formula/gnupg)
```t
# Install gnupg on MacOS
brew install gnupg

# Verify version
gpg --version
```
### Step-02-02: Install gnupg on WindowsOS
- [Install gnupg on windows using chocolatey](https://community.chocolatey.org/packages/gnupg#individual)
```t
# Install gnupg on WindowsOS
choco install gnupg

# Verify version
gpg --version
```

## Step-03: Generate Private/Public Key Pairs with gpg
```t
# List Keys
gpg --list-keys

# Generating Private/Public Keys with gpg
gpg --full-generate-key
-> kind of key: Select 1 (1) RSA and RSA
-> What keysize do you want? (3072) 
-> Please specify how long the key should be valid.
-> Key is valid for? (0) "0 = key does not expire"
-> Is this correct? (y/N) 
-> Real name: helmsigndemo1
-> Email address: helmsigndemo1@gmail.com
-> Comment: Keys used to sign Helm Charts
-> Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
-> Passphrase: helm1234

# List Keys
gpg --list-keys

# Convert new secret keyring to old format
gpg --export-secret-keys >~/.gnupg/helmsigndemo1-secring-privatekey.gpg
Passphrase: helm1234
Additional Notes:
1. To sign charts, Helm currently prefers the older format. 
2. Convert the new secret keyring format to the old format and store it in a file called secring.

# Verify if file created
ls ~/.gnupg/helmsigndemo1-secring-privatekey.gpg

# Copy the private key to course directory
cd 43-Helm-Sign-and-Verify-Charts 
cp ~/.gnupg/helmsigndemo1-secring-privatekey.gpg myhelmcharts/private-key/

# Export private key with single command (instead of export in .gnupg folder and copy to private-key folder)
cd myhelmcharts
gpg --export-secret-keys > private-key/helmsigndemo1-secring-privatekey.gpg
```

## Step-03: Signing Helm Charts
```t
# Change Directory
cd myhelmcharts
1. we will have the "myfirstchart" helm chart folder

# Sign & Package Helm Chart 
helm package --sign --key 'helmsigndemo1' --keyring private-key/helmsigndemo1-secring-privatekey.gpg myfirstchart/
Passphrase: helm1234

# Verify the Provenance file created
ls -lrta
1. We should find the file "myfirstchart-2.0.0.tgz.prov" ending with ".prov"
```

## Step-04: Export Public Key
- Verify integrity of chart using public key
- In real-world scenario, these public keys will be published on keyservers (keyserver.ubuntu.com, keyserver.openpgp.com) 
- We should download these public keys to verify the integrity of the chart.
```t
# Change to Directory 
cd myhelmcharts

# Export Public Key
gpg --export 'helmsigndemo1' > public-key/helmsigndemo1-publickey.gpg

# Verify if file created
ls public-key/helmsigndemo1-publickey.gpg
```

## Step-05: Verify Helm Package using Public Key
```t
# Change Directory
cd myhelmcharts

# Helm Verify
helm verify --keyring public-key/helmsigndemo1-publickey.gpg myfirstchart-0.1.0.tgz

## Sample Output
Kalyans-Mac-mini:myhelmcharts kalyanreddy$ helm verify --keyring public-key/helmsigndemo1-publickey.gpg myfirstchart-0.1.0.tgz
Signed by: helmsigndemo1 (Keys used to sign Helm Charts) <helmsigndemo1@gmail.com>
Using Key With Fingerprint: 0494EA24668AE1516A31E5EC467D1996D2158381
Chart Hash Verified: sha256:099c8a0cd0609f0e252bd63856ea1998c55e4af1b587c435d4b74d33283e0ad4
Kalyans-Mac-mini:myhelmcharts kalyanreddy$ 
```


## Step-06: Verify Charts during helm install and Upgrade - Positive Test
```t
# Change Directory
cd myhelmcharts

# Helm Install with --verify 
helm install myapp1 myfirstchart-0.1.0.tgz --verify --keyring public-key/helmsigndemo1-publickey.gpg --atomic

# List Helm Release
helm list

# Helm Status
helm status --show-resources

# Access Application
http://localhost:31239

# Helm Upgrade with --verify 
helm upgrade myapp1 myfirstchart-0.1.0.tgz --verify --keyring public-key/helmsigndemo1-publickey.gpg --atomic --set image.tag="0.2.0"

# Uninstall Helm Release
helm uninstall myapp1
```


## Step-07: Verify Charts during helm install and Upgrade - Negative Test
```t
# Change Directory
cd myhelmcharts

# Create some dummy file in public-key folder
touch public-key/dummy-publickey.gpg

# Helm Install with --verify 
helm install myapp1 myfirstchart-0.1.0.tgz --verify --keyring public-key/dummy-publickey.gpg --atomic
Observation:
1. Should throw an error as below

## Sample Output
Kalyans-Mac-mini:myhelmcharts kalyanreddy$ helm install myapp1 myfirstchart-0.1.0.tgz --verify --keyring public-key/dummy-publickey.gpg --atomic
Error: INSTALLATION FAILED: openpgp: signature made by unknown entity
Kalyans-Mac-mini:myhelmcharts kalyanreddy$ 
```
