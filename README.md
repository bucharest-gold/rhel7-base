# rhel7-base
RHEL7 source-to-image for RHOAR Node.js


### Build

```
make USER=user PASS=password
```


### Image size

```
$ docker images
REPOSITORY                                                                    TAG                                                                IMAGE ID            CREATED             SIZE
bucharestgold/rhel7-base                                                      latest                                                             7b27ee214c03        6 minutes ago       365MB ****
registry.access.redhat.com/rhel7                                              latest                                                             eb205f07ce7d        6 days ago          203MB
centos/s2i-base-centos7                                                       latest                                                             afec3923eaac        3 weeks ago         468MB
registry.access.redhat.com/rhscl/s2i-base-rhel7                               latest                                                             24abd603df25        5 weeks ago         456MB
```