## Service mesh 是什么，为什么我们需要？
在过去的几年中，Service mesh 以及成为云原生技术栈中重要的组件，像Paypal,
Ticketmaster, and Credit Karma
这样的大流量公司都在它们的生成产品中使用了Service mesh。 而这个一月，Linkerd
：开源的云原生应用，已经成为CNCF官方项目。 这篇文章，将给出Service mesh
的定义，并回顾应用程序架构在过去几十年间的它的演变历史。 并将区分出Sm和 api-gw
边缘代理，企业服务总线 的这些相关概念之间的明显差别。
最后，我将将描绘Sm未来的发展方向，以及随着云原生应用的发展，这个概念将会发生什么变化呢?

Sm是什么 Sm
是致力于解决服务之间通讯的基础设施层，他负责在现代云原生应用程序的复杂服务拓扑来可靠地传递请求。
实际上，Sm通常是通过一组轻量级网络代理（Sidecar 
proxy），与应用程序代码部署在一起实现，而无需感知应用程序本身。
（但是目前对此会有几种变化的版本，接下来会看到）

Sm作为独立层的概念与云原生的兴起有关， 在云原生模式下，一个应用程序可能会由几百个服务所构成，
而每个服务又会有几百个实例，，并且每个服务实例由于在被像k8s这样的协调器在动态调度着，其状态持续在的发生变化。

服务之间的通讯不仅非常复杂，而且它还是运行时行为的普遍和基本部分。
管理好这些对确保 端对端性能和可靠性是至关重要的。

Sm是网络模式吗？ Sm是网络模型 是位于网络之上TCP/IP抽象层，它假设底层的L3/L4网络是存在的，并且能够在点与点之间传递字节。
(它还假定，这个网络同环境的所有其他方面一样，是不可靠的;因此，服务网格也必须能够处理网络故障。)


从某些方面而言，Sm 同TCP/IP 类似： Tcp/Ip
抽象了在服务端点之间可靠地交付字节，而Sm则抽象了在服务断点之间可靠地交付请求的机制。
与Tcp一样，Sm并不关心实际的有效负载，或它是如何编码的。应用程序有一个高级目标，“从a发送一些东西到B”)，服务网格的工作，就像TCP的工作一样，是在处理过程中的任何失败时完成这个目标。

与TCP不一样的是，SM除了使其能够工作外，还有一个重要目标，：它提供了一个统一的应用程序范围的点，用于将可见性和控制引入应用程序运行时。
Sm的目前目标是将服务通讯从不可见的，隐讳的基础设施领域转移到生态系统的一级成员的角色，，在那里可以监视，管理和控制服务通讯。


Sm 实际是干嘛的？ 

在云原生应用下去可靠地传输请求可能会达到难以想象地复杂。 一个像Linked这样的Sm
