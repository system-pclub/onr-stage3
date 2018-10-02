## onr-stage3

The code repository for onr supported projects

### 1. Prepare Your Runtime Env

- Ubuntu 16.04 and run upgrade.

- Install llvm 5.0, you can follow [install-llvm](install-llvm.txt).

### 2. Build and Run the Demo

- Enter scripts folder and run [build-pass.sh](./scripts/build-pass.sh)

- Enter stubs/demo folder and run [test-demo.sh](./stubs/demo/test-demo.sh)

### 3. Contribute Your Code

- You can follow DemoPass

- Build your code by running [build-pass.sh](./scripts/build-pass.sh)

- Copy test-demo.sh and modify the new script to test your code

### 4. Commit Your code

- Please run [clean-build.sh](./scripts/clean-build.sh) in scripts folder to clean your build

- Please use "git add -f xxx" and avoid using "git add *"
