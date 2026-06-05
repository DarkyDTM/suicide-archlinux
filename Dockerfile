FROM archlinux/archlinux

RUN pacman -Syu --noconfirm fish

COPY config.fish /etc/fish/

ENTRYPOINT ["fish"]
