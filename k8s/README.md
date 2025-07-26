# Kubernetes Configuration for Eight Rails App

This directory contains Kubernetes manifests for deploying the Eight Rails application with persistent SQLite storage.

## Files Overview

- `namespace.yaml`: Creates a dedicated namespace for the application
- `persistent-volume.yaml`: Defines PV and PVC for shared storage (used with Deployment)
- `deployment.yaml`: Standard deployment with shared persistent volume
- `statefulset.yaml`: Alternative StatefulSet deployment with individual persistent volumes per pod
- `service.yaml`: LoadBalancer service to expose the application
- `secret.yaml`: Template for storing Rails master key

## Deployment Options

### Option 1: Deployment with Shared Storage
Use this when all pods can share the same SQLite database file:

```bash
kubectl apply -f namespace.yaml
kubectl apply -f persistent-volume.yaml
kubectl apply -f secret.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

### Option 2: StatefulSet with Individual Storage
Use this when each pod needs its own persistent storage:

```bash
kubectl apply -f namespace.yaml
kubectl apply -f secret.yaml
kubectl apply -f statefulset.yaml
kubectl apply -f service.yaml
```

## Important Notes

1. **SQLite Limitations**: SQLite has limitations with concurrent writes. For production use with multiple pods, consider:
   - Using PostgreSQL or MySQL instead
   - Implementing proper database locking mechanisms
   - Using a single-pod deployment for write operations

2. **Secret Configuration**: Before deploying, update `secret.yaml`:
   ```bash
   # Get your Rails master key
   cat config/master.key
   
   # Encode it in base64
   echo -n "your-master-key" | base64
   
   # Update the rails-master-key value in secret.yaml
   ```

3. **Storage Class**: The manifests use `standard` storage class. Adjust based on your cluster:
   - AWS EKS: `gp2`
   - GKE: `standard`
   - Azure AKS: `default`

4. **Access Modes**:
   - Deployment uses `ReadWriteMany` for shared access
   - StatefulSet uses `ReadWriteOnce` for individual pod storage

## Monitoring

Check pod status:
```bash
kubectl get pods -n eight-app
```

Check persistent volumes:
```bash
kubectl get pv
kubectl get pvc -n eight-app
```

View logs:
```bash
kubectl logs -f deployment/eight-app -n eight-app
```