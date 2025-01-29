# Project Navigator
Are your c and d keys worn out from overuse everytime you re-open a project?  
Worry no more! This project navigator can help you easily navigate to your deeply nested repositories.  
<p align="center">
  <img src="https://github.com/Arif-Khalid/project_navigator/blob/main/images/project_navigator_example.png" alt="Project Navigator Example"/>
</p>  

# Installation
This project uses ``bash`` as the operative shell. It likely needs refactoring to work in other shells.
1. Clone the repo or copy the file ``pn.sh`` and ``projects.txt`` into the same folder. I put it into a local ``~/.project_navigator`` directory, it doesn't really matter. However, the file names cannot be changed and they must be in the same directory
2. Edit ``projects.txt`` with your own projects' names and paths
    1. Use the same format for adding new projects as the examples in projects.txt. Explicitly, the format is ``YOUR_PROJECT_NAME=YOUR_PROJECT_ROOT_DIRECTORY``, with each new project on a new line 
    2. Use full paths without env variables or ``~``. You can get the full file path to your project by doing ``readlink -f .`` from the root of your project
## Optional
3. Add the following line to your shell config ``alias pn=". $HOME/path/to/your/folder/containing/this_file/pn.sh"``  
    1. Shell config files are dependent on shell and operating system used, for bash in linux, they can be found or created at
"/etc/profile", "\~/bash_profile" or "\~/.bashrc".
    2. Can be done by running ``echo 'alias pn=". $HOME/path/to/your/folder/containing/this_file/pn.sh"' >> $HOME/.bashrc``
4. Quit and re-open the terminal or run ``source ~/.bashrc``

# Usage
1. Use the tool by running ``. full/path/to/your/folder/pn.sh`` in your terminal
    1. If you did the optional step 3, you can also run the tool by using ``pn`` in your terminal
2. Navigate to your desired project by typing the project index as prompted

# Additional Information
This is a casual project to help me navigate to my files easily through CLI.  
The best use case is when working with multiple projects and you want to use CLI to navigate to those local repositories quickly.  
Hope this manages to help someone apart from myself 🤓.
