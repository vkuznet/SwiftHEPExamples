### SwiftCMSPython
A collection of random code to demonstrate usage of Swift for
HEP. Examples includes
- python interoperability
- numpy, matplotlib and [uproot](https://github.com/scikit-hep/uproot) usage

### Build notes
To setup full working environment you need:
- [Swift for Tensorflow](https://github.com/tensorflow/swift) toolchain
- [Anaconda](https://www.anaconda.com/products/individual) setup for uproot:
```
# install anconda
curl -ksLO "https://repo.anaconda.com/archive/Anaconda3-2020.07-MacOSX-x86_64.sh"
sh Anaconda3-2020.07-MacOSX-x86_64.sh -u

# setup proper environment and install python dependencies
conda create --name uproot python=3.8
conda activate uproot
conda install -c conda-forge uproot matplotlib

# setup proper PATHs environments for swift usage of python
# please change /opt/anaconda3 to whatever path you may have
export PATH=/opt/anaconda3/bin:$PATH
export PATH=/Library/Developer/Toolchains/swift-latest/usr/bin:$PATH
export PYTHON_LIBRARY=/opt/anaconda3/envs/uproot/lib/libpython3.8.dylib
export PYTHONPATH=/opt/anaconda3/envs/uproot/lib/python3.8:/opt/anaconda3/envs/uproot/lib/python3.8/lib-dynload:/opt/anaconda3/envs/uproot/lib/python3.8/site-packages

# build swift code
swift build

# run swift code
swift run
```
