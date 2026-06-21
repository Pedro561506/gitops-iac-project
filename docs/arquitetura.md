 # Arquitetura do Projeto GitOps IaC

## Visão Geral

O projeto utiliza GitOps para gerenciamento da infraestrutura e dos ambientes Kubernetes.

A infraestrutura é versionada no GitHub, validada pelo GitHub Actions e provisionada em um cluster Kubernetes local utilizando Terraform e Kustomize.

## Fluxo da Solução
 
 

 
 
                 +----------------+

                 |     GitHub     |

                 | Repositório IaC|

                 +--------+-------+

                          |

                    Pull Request

                          |

                 +--------v-------+

                 | GitHub Actions |

                 | CI / Validação |

                 +--------+-------+

                          |

                   Merge Main

                          |

                 +--------v-------+

                 |    GitOps      |

                 | Kustomize      |

                 +--------+-------+

                          |

              +-----------+------------+

              |                        |

        +-----v-----+            +-----v-----+

        | Namespace |            | Namespace |

        |    dev    |            |    hml    |

        +-----------+            +-----------+

              |                        |

        Deployment               Deployment

         1 réplica                2 réplicas