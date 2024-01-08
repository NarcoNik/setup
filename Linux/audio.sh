echo '#### Audio'
echo '#################################################################'
sudo apt -y install linux-sound-base alsa-base alsa-utils alsa-tools
sudo gedit /etc/modprobe.d/alsa-base.conf
# paste after all text
options snd-hda-intel position fix=1
options snd-hda-intel model=alc298-dell1

# options snd-hda-codec-realtek dyndbg
# options snd-hda-intel model=,dell-headset-multi
# options snd-hda-intel model=dell-headset3
# options snd-hda-intel patch=alc298-sound-patch.fw,alc298-sound-patch.fw,

sudo echo «ControllerMode = bredr» /etc/bluetooth/main.conf
sudo service bluetooth restart

alsamixer
# press F6 & after, select correct audio card
sudo alsa force-reload

echo '#################################################################'
pacmd list-sinks

amixer -c 0 sset "Auto-Mute Mode" Enabled
pactl set-sink-port 0 'Speaker'

-Скачать эту программу:
sudo apt -y install pavucontrol

-Какие именно методы дискритизации поддерживает ваш компьютер:
pulseaudio --dump-resample-methods

-Изменение метода дискритизации и улучшение звука в наушниках:
sudo gedit /etc/pulse/daemon.conf

находим строчку и убераем знак ; в самом начале строки
resample-method = ""(без ковычек впишите нужный вам метод)

resample-method = soxr-vhq

находим эти строки и так же убераем знак ; в начале каждой строки
default-sample-format = s16le
default-sample-rate = 48000
; alternate-sample-rate = 48000
default-sample-channels = 2
default-channel-map = front-left,front-right

sudo gedit ./default.pa
load-module module-echo-cancel source_name=noechosource sink_name=noechosink
set-default-source noechosource

--Далее либо перезагружаем ПК,либо прописываем команду в терминале:
pulseaudio -k
pulseaudio -D --start
Через несколько секунд изменения вступят в силу.
