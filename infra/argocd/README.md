# Argo CD bootstrap for sion2k.ru

Apply once:

```bash
kubectl apply -f infra/argocd/bootstrap.yaml
```

This creates:

- `sion2k-site-gitops` — app-of-apps in `shturval-cd`, tracks this directory
- `sion2k-site` — deploys `deploy/` into namespace `sion2k-site`

Release flow:

1. Push tag `vX.Y.Z`
2. GitHub Actions builds and pushes `registry.sion2k.ru/home/sion2k-site:X.Y.Z`
3. Workflow updates `deploy/kustomization.yaml` `newTag` on `main`
4. Argo CD syncs the new image

Pull secret (one-time, not in git):

```bash
./infra/scripts/apply-registry-pull-secret.sh sion2k-site
```
