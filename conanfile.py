from conan import ConanFile
from conan.tools.cmake import CMake, cmake_layout

class cxx_project_template_conan(ConanFile):
    name = "cxx_project_template"
    version = "1.0.0"

    # Set the license for your project
    license = ""

    # URL for the project's homepage
    url = "https://yourprojecthomepage.com"

    # Author(s) of the project
    author = "Your Name <your.email@example.com>"

    # A short description of your project
    description = "A brief description of your project"

    # Topics can help with indexing and searchability
    topics = ("conan", "cpp", "library")

    # Settings for the project, such as compiler and build type
    settings = "os", "arch", "compiler", "build_type"

    # Options your package may support, example: shared library or static
    options = {"shared": [True, False]}
    default_options = {"shared": False}

    # Dependencies can be other Conan packages
    requires = (
        "fmt/10.2.1",
        # Add more dependencies as needed
    )

    # Generators for integrating with build systems
    generators = "CMakeDeps", "CMakeToolchain"

    # Configuration for layout, helping to define source, build, and package folders
    def layout(self):
        cmake_layout(self)

    # Use the `build` method to define how your project is built
    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()
