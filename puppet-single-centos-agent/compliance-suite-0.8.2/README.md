# Compliance-suite

## Function

This suite delivers security controls alongside the Cyber Deployment suite

* They will no longer be part of the deployment suite as they have to move at a different cadence to the core product
* The actual control resources will be marshalled by a new “bt-compliance” puppet module 
* Replacement profiles::compliance::\* classes have been supplied and breaking changes to interface contract have been minimised
* All controls will be benchmarked to the CIS 2.2.0 standard on CentOS 7.6 as measured by Nessus Professional

## Integration with existing puppet environment

Assumptions:

1. You are using r10k for puppet environment deployment
2. You have your relevant branch for your control repo cloned as ./control
3. You have unpacked the compliance suite into ./pla.puppet.compliance-suite
4. You have the compliance module in some repo/forge

```
  # cp -r ./pla.puppet.compliance-suite/profiles ./control/site/
  # cp -r ./pla.puppet.compliance-suite/data/common/compliance ./control/data/common
  # cat ./pla.puppet.compliance-suite/Puppetfile >> ./control/Puppetfile
  # vim control/Puppetfile
```
Review what needs to be in the Puppetfile and point to your own repos/forges.

Commit and push your environment branch back to your git server, then use r10k to deploy.

Alternative integration into deployment-suite monolith:

What you need to do is:

1. Locate the compliance-suite-X.Y.Z.zip
2. Extract the compliance-suite puppet module and places it into /tmp/production/modules
    * Extract the files from the zip.
    ```bash
    unzip compliance-suite-X.Y.Z.zip -d compliance-suite
    ```
    * Extract the modules from module_name-X.Y.Z.tar.gz tarball within the modules dir
    ```bash
    pushd compliance-suite/modules/
    for f in *.tar.gz; do tar xf "$f"; done
    rm -rf *tar.gz
    mv bt-compliance-* compliance
    popd
    ```
3. Copy the files into your Puppet Server environment
    * Copies profiles::compliance into /tmp/production/site
    * Copies hiera data and places it in /tmp/production/data
```bash
cp compliance-suite/* /etc/puppetlabs/code/environments/production/ -r
```
