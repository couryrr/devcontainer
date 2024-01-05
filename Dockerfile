FROM ubuntu:22.04

# USER DETAILS
ARG USERNAME=somedev
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# CREATE THE USER AND ADD TO SUDOERS
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt update && apt upgrade -y \
    && apt install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

#SWITCH TO THIS USER
USER $USERNAME

#$HOME DOES NOT SEEM TO WORK
#SET WORK TO USER HOME
#IS THIS NEEDED?
WORKDIR /home/$USERNAME

#BASIC PACKAGES
RUN sudo apt install curl zsh git fonts-font-awesome vim jq httpie make sqlite3 -y

#ADD OMZ, THEMES AND PLUGIN
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    && sudo chsh -s $(which zsh) $USERNAME 

#SWITCH THE SHELL... IS THIS A GOOD IDEA?
SHELL [ "/bin/zsh", "-c" ]

COPY --chown=$USERNAME:USERNAME .vimrc /home/$USERNAME/.vimrc

#THERE IS AN ISSUE WITH KEY BINDINGS USING APT
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /home/$USERNAME/.fzf  && /home/$USERNAME/.fzf/install

RUN source /home/$USERNAME/.zshrc && omz theme set af-magic && omz plugin enable git jump fzf
