Return-Path: <cygwin-patches-return-3086-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7369 invoked by alias); 25 Oct 2002 19:36:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7321 invoked from network); 25 Oct 2002 19:36:58 -0000
Message-ID: <3DB99F1F.51A3BDD0@pajhome.org.uk>
Date: Fri, 25 Oct 2002 12:36:00 -0000
From: Paul Johnston <paj@pajhome.org.uk>
X-Accept-Language: en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: cygwin-mketc.sh
Content-Type: multipart/mixed;
 boundary="------------CA755F19C1D191A05D5A8A38"
X-SW-Source: 2002-q4/txt/msg00037.txt.bz2

This is a multi-part message in MIME format.
--------------CA755F19C1D191A05D5A8A38
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 595

Hi,

Windows has direct equivalents of some standard unix files: /etc/hosts,
services, protocols, networks. It is helpful to have symbolic links from
these files in /etc to the windows equivalents. A few weeks ago we
talked about this on the main cygwin list. Some of us came up with this
postinstall script, which has been tested and hardened against windows
95/98/ME and NT4/2000/XP (not been tested on NT 3.51). Under NT it works
with both NTFS and FAT, and it works with strict_case=yes.

I think it should go in the main cygwin package and install as
/etc/postinstall/cygwin-mketc.sh

Paul

--------------CA755F19C1D191A05D5A8A38
Content-Type: application/x-sh;
 name="cygwin-mketc.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-mketc.sh"
Content-length: 882

#!/bin/sh
#--
# Create symbolic links from some /etc files to the Windows equivalents
#--

FILES="hosts protocols services networks"

OSNAME="`/bin/uname -s`"
WINHOME="`/bin/cygpath -W`"

CYGWIN="$CYGWIN check_case:relaxed"
export CYGWIN

case "$OSNAME" in
  CYGWIN_NT*) WINETC="$WINHOME/system32/drivers/etc" ;;
  CYGWIN_9*|CYGWIN_ME*) WINETC="$WINHOME" ;;
  *) 
    echo "Unknown system type $OSNAME; exiting" >&2
    exit 0
  ;;
esac

WINETC="$(/bin/cygpath -u "$(/bin/cygpath -w -l "$WINETC")")"
if [ ! -d "$WINETC" ]
then
  echo "Directory $WINETC does not exist; exiting" >&2
  exit 0
fi

for FILE in $FILES
do
  if [ ! -e "/etc/$FILE" -a ! -L "/etc/$FILE" ]
  then
    # Windows only uses the first 8 characters
    WFILE="$WINETC/`expr substr "$FILE" 1 8`"
    WFILE="$(/bin/cygpath -u "$(/bin/cygpath -w -l "$WFILE")")"
    /bin/ln -s -v "$WFILE" "/etc/$FILE"
  fi
done




--------------CA755F19C1D191A05D5A8A38--
