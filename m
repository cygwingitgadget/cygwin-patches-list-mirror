Return-Path: <cygwin-patches-return-3512-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29475 invoked by alias); 5 Feb 2003 18:23:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29463 invoked from network); 5 Feb 2003 18:23:59 -0000
Message-Id: <3.0.5.32.20030205132330.007f1a70@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Wed, 05 Feb 2003 18:23:00 -0000
To: Igor Pechtchanski <pechtcha@cs.nyu.edu>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: ntsec odds and ends (cygcheck augmentation?)
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.GSO.4.44.0302051226520.25432-100000@slinky.cs.nyu.edu
 >
References: <3.0.5.32.20030205122144.007edd30@h00207811519c.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-SW-Source: 2003-q1/txt/msg00161.txt.bz2

At 12:31 PM 2/5/2003 -0500, Igor Pechtchanski wrote:
>Pierre,
>
>IMHO, "No entry" is a better name for such a situation ([ug]id=3D=3D-1).  =
It
>could then be documented in the FAQ.  Just my 2=A2...

Igor,

That's something else. ls -l print 65535 when the sid cannot be mapped=20
to a uid/gid, which is NEVER the case for the current user. By the way, it
will now print ????????  (because 65535 would become 4294967295 (truncated
to 8 characters) when we move to uid32).=20
We can change the ??????? to whatever people wish (it's in variables=20
called "pretty_ls").

When the user is not in passwd, ls -l would print a special string in the=20
group field. I would like something more precise than "No entry".=20
To a new user "No entry" is not very alarming, nor very informative.
mkpasswd is proper to Cygwin, how can we best communicate its existence?

By the way, when we move to a new setup.exe, without passwd-grp.bat and
with a new passwd-gr.sh, the passwd problem will disappear but the HOME
issue will remain.

>How about just "Warning: HOME set to 'C:\', check your /etc/passwd or the
>value of HOME in the Windows environment"?  An advanced user (or one who
>simply wants to set his home to 'C:\') should be able to just comment out
>this warning from /etc/profile, right?

Right, that's the idea. When everything is fine the user should delete the
diagnostic code. Note however that we should check for more than c:\

Pierre
