. ~/.bashrc


# MacPorts adding an appropriate PATH variable for use with MacPorts.
if [ -d /opt/local ]; then
	export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
fi

## mysql56
if [ -d /opt/local/lib/mysql56 ]; then
	export PATH="/opt/local/lib/mysql56/bin/:$PATH"
fi


# load script outside this repository
if [ -r ~/.bash_extra.sh ]; then
	. ~/.bash_extra.sh
fi
