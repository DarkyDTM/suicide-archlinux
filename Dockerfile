FROM archlinux/archlinux

COPY config.fish /etc/fish/

ENTRYPOINT ["bash"]
