# HPC

Trying to improve performance of my 4 computer cluster for CFD. Currently using
gigabit networking to connect and seems to cause anywhere from a ~30% reduction
in performance to a huge one depending on problem and solver

Purchasing the following set of networking equipment to try out
[MikroTik CRS305-1G-4S+IN](https://www.amazon.com/gp/product/B07LFKGP1L/ref=crt_ewc_title_srh_3?ie=UTF8&psc=1&smid=A2FXJMK2DLQ8YY)
[10Gtek 10Gb PCI-E NIC Network Card](https://www.amazon.com/gp/product/B01LZRSQM9/ref=crt_ewc_title_dp_2?ie=UTF8&psc=1&smid=AE2OZG2NN3099)
[10Gtek 10G SFP+ DAC Cable](https://www.amazon.com/gp/product/B00WHS3NCA/ref=crt_ewc_title_dp_4?ie=UTF8&psc=1&smid=AE2OZG2NN3099)

SFP+ supposedly has better latency than 10G RJ45 connections which I would think
could be an issue in CFD code depending on how frequently the processes need to
talk to each other.

[Benchmarks](https://www.microway.com/knowledge-center-articles/performance-characteristics-of-common-network-fabrics/)

According to this site, 1G has 25-65 microsecond latency. 10G has 1.3
microsecond latency for RDMA or 4 microsecond latency for sockets. It seems like
openmpi can use RDMA if it detects it but haven't looking into how that works
[Link](https://github.com/open-mpi/ompi/issues/5789)

According to another site
[Link](https://www.datacenterknowledge.com/archives/2012/11/27/data-center-infrastructure-benefits-of-deploying-sfp-fiber-vs-10gbase-t)
10G over SFP+ has 0.3 microsecond latency and 10GBase-T has 2-2.5 microsecond
latency. SFP+ also uses way less power.

On the amazon page for one of the components, there's talk of some code thats
stored in the connectors to require certain connectors for certain products. No
idea if it applies to what I purchased
