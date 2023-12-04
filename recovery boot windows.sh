diskpart
list disk
read a
echo `select disk $a`

sel disk $a
list volume
read b
echo `select volume $b`

select volume $b
assign letter K:
exit

cd /d K:\Boot\
# or
# cd /d K:\ESD\Windows\EFI\Microsoft\Boot\
attrib BCD -s -h -r
ren BCD BCDold
bcdboot C:\Windows /l en-us /s k: /f ALL

diskpart
list disk

sel disk $a
list volume

select volume $b
remove letter K:
exit
