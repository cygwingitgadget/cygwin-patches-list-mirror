Return-Path: <cygwin-patches-return-4624-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31010 invoked by alias); 23 Mar 2004 15:15:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30963 invoked from network); 23 Mar 2004 15:15:27 -0000
Date: Tue, 23 Mar 2004 15:15:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch 20040321 for audio recording with /dev/dsp (indented), test issues
Message-ID: <20040323151525.GA3150@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01C41057.52EAB850.Gerd.Spalink@t-online.de> <20040323110933.GM17229@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20040323110933.GM17229@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00114.txt.bz2


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 338

On Tue, Mar 23, 2004 at 12:09:33PM +0100, Corinna Vinschen wrote:
>Chris, do you have a personally approved set of indent options which
>give a useful result, perhaps?

No, I don't use indent very often.

Gdb has an indent script, though.  I've attached it to this message.  I
can't confirm or deny if it works well for c++, though.

cgf

--sm4nu43k4a2Rpi4c
Content-Type: application/x-sh
Content-Disposition: attachment; filename="gdb_indent.sh"
Content-Transfer-Encoding: quoted-printable
Content-length: 2391

#!/bin/sh=0A=
=0A=
# Try to find a GNU indent.  There could be a BSD indent in front of a=0A=
# GNU gindent so when indent is found, keep looking.=0A=
=0A=
gindent=3D=0A=
indent=3D=0A=
paths=3D`echo $PATH | sed \=0A=
	-e 's/::/:.:/g' \=0A=
	-e 's/^:/.:/' \=0A=
	-e 's/:$/:./' \=0A=
	-e 's/:/ /g'`=0A=
for path in $paths=0A=
do=0A=
    if test ! -n "${gindent}" -a -x ${path}/gindent=0A=
    then=0A=
	gindent=3D${path}/gindent=0A=
	break=0A=
    elif test ! -n "${indent}" -a -x ${path}/indent=0A=
    then=0A=
	indent=3D${path}/indent=0A=
    fi=0A=
done=0A=
=0A=
if test -n "${gindent}"=0A=
then=0A=
    indent=3D${gindent}=0A=
elif test -n "${indent}"=0A=
then=0A=
    :=0A=
else=0A=
    echo "Indent not found" 1>&2=0A=
fi=0A=
=0A=
=0A=
# Check that the indent found is both GNU and a reasonable version.=0A=
# Different indent versions give different indentation.=0A=
=0A=
m1=3D2=0A=
m2=3D2=0A=
m3=3D9=0A=
=0A=
version=3D`${indent} --version 2>/dev/null < /dev/null`=0A=
case "${version}" in=0A=
    *GNU* ) ;;=0A=
    * ) echo "error: GNU indent $m1.$m2.$m3 expected" 1>&2 ; exit 1;;=0A=
esac=0A=
v1=3D`echo "${version}" | sed 's/^.* \([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)$/\1=
/'`=0A=
v2=3D`echo "${version}" | sed 's/^.* \([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)$/\2=
/'`=0A=
v3=3D`echo "${version}" | sed 's/^.* \([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)$/\3=
/'`=0A=
=0A=
if test $m1 -ne $v1 -o $m2 -ne $v2 -o $m3 -gt $v3=0A=
then=0A=
    echo "error: Must be GNU indent version $m1.$m2.$m3 or later" 1>&2=0A=
    exit 1=0A=
fi=0A=
=0A=
if test $m3 -ne $v3=0A=
then=0A=
    echo "warning: GNU indent version $m1.$m2.$m3 recommended" 1>&2=0A=
fi=0A=
=0A=
# Check that we're in the GDB source directory=0A=
=0A=
case `pwd` in=0A=
    */gdb ) ;;=0A=
    */sim/* ) ;;=0A=
    * ) echo "Not in GDB directory" 1>&2 ; exit 1 ;;=0A=
esac=0A=
=0A=
=0A=
# Run indent per GDB specs=0A=
=0A=
types=3D"\=0A=
-T FILE \=0A=
-T bfd -T asection -T pid_t \=0A=
-T prgregset_t -T fpregset_t -T gregset_t -T sigset_t \=0A=
-T td_thrhandle_t -T td_event_msg_t -T td_thr_events_t \=0A=
-T td_notify_t -T td_thr_iter_f -T td_thrinfo_t \=0A=
`cat *.h | sed -n \=0A=
    -e 's/^.*[^a-z0-9_]\([a-z0-9_]*_ftype\).*$/-T \1/p' \=0A=
    -e 's/^.*[^a-z0-9_]\([a-z0-9_]*_func\).*$/-T \1/p' \=0A=
    -e 's/^typedef.*[^a-zA-Z0-9_]\([a-zA-Z0-9_]*[a-zA-Z0-9_]\);$/-T \1/p' \=
=0A=
    | sort -u`"=0A=
=0A=
${indent} ${types} "$@"=0A=

--sm4nu43k4a2Rpi4c--
