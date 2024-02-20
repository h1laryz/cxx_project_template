#!/bin/bash

# Name of the Conan profile to check or create
PROFILE_NAME="cxx_project_template"

# Check if the profile already exists
conan profile list | grep -q "^${PROFILE_NAME}$"

# Check the exit status of the grep command
if [ $? -eq 0 ]; then
    echo "Profile '${PROFILE_NAME}' already exists."

else
    echo "Profile '${PROFILE_NAME}' does not exist. Creating it..."
    # Create the profile with the specified name
    # Note: Adjust the following 'conan profile detect' command according to your needs
    conan profile detect --name ${PROFILE_NAME}
    
    # Optional: Customize the profile as needed
    # e.g., Set specific settings or options
    # conan profile update settings.compiler.version=11 ${PROFILE_NAME}
    # conan profile update settings.compiler.libcxx=libstdc++11 ${PROFILE_NAME}
    
    echo "Profile '${PROFILE_NAME}' has been created."
fi
