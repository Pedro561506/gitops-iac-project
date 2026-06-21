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