FROM archlinux/archlinux

COPY bash.bashrc /etc/

ENTRYPOINT ["bash"]
