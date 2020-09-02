// load python module
#if canImport(PythonKit)
    import PythonKit
#else
    import Python
#endif

// generic Python code
print(Python.version)
let pdict: PythonObject = ["foo": [0], "bar": [1, 2, 3]]
print("python dict: \(pdict)")

// 3d party python library
let np = Python.import("numpy")
let arr = np.array([1,2,3])
print("numpy array: \(arr)")

// CMS specific code
// let's import python system library and add to our path DMWM python stack
let sys = Python.import("sys")
print("system path: \(sys.path)")
sys.path.append("/Users/vk/CMS/DMWM/GIT/WMCore/src/python")
let utils = Python.import("Utils.Utilities")
print(utils.strToBool("True"))

// load uproot
var furl = "http://scikit-hep.org/uproot/examples/nesteddirs.root"
print("uproot: \(furl)")
let uproot = Python.import("uproot")
var file = uproot.open(furl)
let keys = file.keys()
print("uproot keys: \(keys)")
let vals = file["one"].values()
print("uproot values: \(vals)")
for item in file.allitems() {
    print(item)
}

// another use case
furl = "http://scikit-hep.org/uproot/examples/Zmumu.root"
print("uproot: \(furl)")
file = uproot.open(furl)
let events = file["events"]
print("name: \(events.name) title: \(events.title) numentires: \(events.numentries)")
events.show()
let arrE = np.array(events.array("E1"))
print("energy: \(arrE)")

// let's create histograms
let bound = 120
var counts = np.array(np.zeros(bound), dtype: np.float32)
var edges = np.array(np.zeros(bound), dtype: np.float32)

for data in events.iterate(["E*", "p[xyz]*"], namedecode: "utf-8") {
    // operate on a batch of data in the loop
    let mass = np.sqrt(np.power(data["E1"] + data["E2"], 2) -
                       np.power(data["px1"] + data["px2"], 2) -
                       np.power(data["py1"] + data["py2"], 2) -
                       np.power(data["pz1"] + data["pz2"], 2))

    // accumulate results
    let hist = np.histogram(mass, bins: bound, range: [0, bound])
    counts += hist[0]
    edges = hist[1]
}

// add matplotlib handler
let matplotlib = Python.import("matplotlib")
matplotlib.use("Agg")
let plt = Python.import("matplotlib.pyplot")
plt.step(x: edges, y: np.append(counts, 0), where: "post");
plt.xlim(edges[0], edges[-1]);
let cmax = counts.max()!
plt.ylim(0, cmax * 1.1);
plt.xlabel("mass");
plt.ylabel("events per bin");
plt.savefig("mass.pdf")
