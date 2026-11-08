sudo tee /usr/local/sbin/preparar-boot-mint-root > /dev/null <<'EOF'
#!/bin/bash
set -eu

if [ "$#" -ne 0 ]; then
    echo "Este comando não aceita argumentos." >&2
    exit 2
fi

ENTRY=$(/usr/bin/efibootmgr -v |
    /usr/bin/awk '
        /^Boot[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]/ &&
        /File\(\\EFI\\ubuntu\\shimx64\.efi\)/ &&
        /47b4cdd1-a747-4f88-b11e-ac6c9e348ac7/ {
            if (match($0, /^Boot[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]/)) {
                print substr($0, 5, 4)
                exit
            }
        }')

if [ -z "$ENTRY" ]; then
    echo "ERRO: entrada UEFI do shim não encontrada." >&2
    exit 1
fi

echo "Entrada encontrada: $ENTRY"
/usr/bin/efibootmgr -n "$ENTRY"
EOF
