# HonestChain Implementation
### **not working condition - cannot reproduce working**

This is a fork of HonestChain in order to try and make a usable version of it. In its current form, HonestChain is unusable due to few reasons:

1. Hyperledger Composer is depreciated
   
   As Composer is depreciated, most of the images this depends on are now unavailable, or removed. Node Packages are either in an unstable/unusable state and need changes in package.json to make it work. In it's current form documentation says Node 8 onwards is supported but in reality anything above version 8 fails, but some of the dependencies require node 10. these conflicts make it nearly impossible to use. 
2. Lack of code
   
   Major parts of code are missing and unavialable. Copying tables with different names was suggested by the author, but these changes were not enough. This also lacks businiess network application file for HonestChain. This makes it impossible to recreate business network in order to use it.

3. Insufficent Documentation
   
   Code was made to it current form by copying code from different repositories. Most of the errors were resolved using trial and error. Composer currently even fails to read cards created by itself. Most of the error resolution needs codes that are depreciated or donot exist in the repository.

In its current form, HonestChain is not implementable, and with the lack of documentation provided by the author, try to implement/recreate this is a lost cause.