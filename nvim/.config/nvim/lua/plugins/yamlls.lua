return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      helm_ls = {
        filetypes = { "helm" },
        settings = {
          ["helm-ls"] = {
            yamlls = {
              enabled = true,
            },
          },
        },
      },
      yamlls = {
        settings = {
          yaml = {
            schemaStore = {
              enable = true,
              url = "https://www.schemastore.org/api/json/catalog.json",
            },
            schemas = {
              -- ArgoCD Application/AppProject CRDs (not core Kubernetes kinds)
              ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"] = "argocd/**/apps/**/*.yaml",
              -- No blanket "kubernetes" mapping: clusters/** mixes core kinds with
              -- lots of CRDs (hypershift.openshift.io NodePool/HostedCluster,
              -- k8s.ovn.org EgressIP, operator.openshift.io IngressController,
              -- metallb.io IPAddressPool, ...), so the bundled core-k8s schema
              -- would flag those CRD kinds as invalid.
            },
            validate = true,
          },
        },
      },
    },
  },
}
