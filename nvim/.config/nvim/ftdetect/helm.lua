-- Helm chart templates use Go templating ({{ }}) inside YAML, so they need
-- helm_ls (which understands templating + CRD kinds) instead of plain yamlls
-- (which forces the strict core-Kubernetes schema and rejects CRD kinds
-- like `NodePool`/`HostedCluster`).
vim.filetype.add({
  pattern = {
    [".*/templates/.*%.ya?ml"] = "helm",
    [".*/templates/.*%.tpl"] = "helm",
    [".*/templates/_.*"] = "helm",
    ["helmfile.*%.ya?ml"] = "helm",
  },
})
