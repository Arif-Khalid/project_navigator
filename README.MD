# Project Navigator
Are your c and d keys worn out from overuse everytime you re-open a project?  
Worry no more! This project navigator can help you easily navigate to your deeply nested repositories.  

# Installation
This project uses ``bash`` as the operative shell. It likely needs refactoring to work in other shells.
1. Clone the repo or copy the file ``pn.sh``. I put it into a local ``~/.project_navigator`` directory but it doesn't really matter
2. Edit the lines projectNames=(...) and projectPaths=(...) with your own project`s names and paths
    1. If you're a rookie <span style="font-size: 10px">like me</span>, be careful when editing the file as shell scripts are space sensitive. Items in the arrays must be space and NOT comma separated
    2. projectNames and projectPaths must be specified in the same relative order, i.e, the first item in projectNames must be the name of the project pointed to by the first item in projectPaths
    3. projectPaths should use appropriate path environment variables such as ``$HOME`` instead of ``~``
## Optional
3. Add the following line to your shell config ``alias pn="$HOME/path/to/your/folder/containing/this_file"``  
    1. Shell config files dependent on shell and operating system used, for bash in linux, they can be found or created at
"/etc/profile", "\~/bash_profile", "\~/.bash_login" or "\~/.profile"
    2. Can be done by running ``echo 'alias pn=". $HOME/path/to/your/folder/containing/this_file/pn.sh"' >> $HOME/.profile``
4. Exit and re-enter the terminal

# Usage
1. Use the tool by running ``. full/path/to/your/folder/pn.sh`` in your terminal
    1. If you did the optional step 3, you can also run the tool by using ``pn`` in your terminal
2. Navigate to your desired project by typing the project index as prompted

This is a casual project to help me navigate to my files easily through CLI.  
The best use case is when working with multiple projects and you want to use CLI to navigate to those local repositories quickly.  
I plan to make the name and path customization more intuitive. Perhaps reading from a separate file instead of editing the shell file.
