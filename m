Return-Path: <cygwin-patches-return-2203-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31380 invoked by alias); 22 May 2002 07:29:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31346 invoked from network); 22 May 2002 07:29:38 -0000
Message-ID: <1264BCF4F426D611B0B00050DA782A50014C22D4@mail.gft.com>
From: =?iso-8859-1?Q?=22Schaible=2C_J=F6rg=22?= <Joerg.Schaible@gft.com>
To: cygwin-patches@cygwin.com
Subject: RE: [PATCH] cygpath.cc
Date: Wed, 22 May 2002 00:29:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-SW-Source: 2002-q2/txt/msg00187.txt.bz2

Hi Corinna,

>AFAICS, the patch is ok.

Fine.

>Just two question:
>
>- The -s and -l options are only valid with the -w option.  Shouldn't
>  either the usage reflect that or the -s and -l options imply -w
>  automatically?  It's not *that* obvious for the user that s/he
>  has to use `cygpath -w -l ...'.

I always had in mind that it would be great to implement the options once
for -u, too.
Example:

$ cygdrive -u `cygdrive -asw \`cygdrive -u 'C:\Dokumente und
Einstellungen\All Users\.bashrc'\``
/cygdrive/c/DOKUME~1/ALLUSE~1/BASHRC~2

It would be nice to have instead:

$ cygdrive -us 'C:\Dokumente und Einstellungen\All Users\.bashrc'
/cygdrive/c/DOKUME~1/ALLUSE~1/BASHRC~2

Another example:
At least on my box W2K is converting TEMP automatically into short form if I
open a console. This is quite inconvenient in bash and I would like to have
rather the long form:

$ echo $TEMP
/cygdrive/c/DOKUME~1/joehni/LOKALE~1/Temp

Prefered call:
$ export TEMP=3D`cygpath -ul $TEMP`
$ echo $TEMP
/cygdrive/c/Dokumente\ und\ Einstellungen/joehni/Lokale\ Einstellungen/Temp

In any case, the normal usage of cygpath should not care about -s or -l,
since you would normally only convert a Unix path into a DOSish notation
(which is by default the long form anyway). Both options are IMHO for very
special purposes.

What bothers me more, is that you cannot convert a short path into the long
version when check_case:strict is set, since the conversion functions in the
cygwin1.dll will reject that path as non-matching. But I am not really sure,
whether this functions should look for the alternative physical name or not.
Another problem arises with Java CLASSPATHs, since their element may be also
files instead of directories, which prevents a conversion unfortunately,
too.

Regards
J=F6rg
