Return-Path: <cygwin-patches-return-3509-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14938 invoked by alias); 5 Feb 2003 17:31:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14921 invoked from network); 5 Feb 2003 17:31:39 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Wed, 05 Feb 2003 17:31:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
To: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
cc: cygwin-patches@cygwin.com
Subject: Re: ntsec odds and ends (cygcheck augmentation?)
In-Reply-To: <3.0.5.32.20030205122144.007edd30@h00207811519c.ne.client2.attbi.com>
Message-ID: <Pine.GSO.4.44.0302051226520.25432-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SW-Source: 2003-q1/txt/msg00158.txt.bz2

On Wed, 5 Feb 2003, Pierre A. Humblet wrote:

> At 11:48 AM 2/5/2003 -0500, Christopher Faylor wrote:
> >Pierre or Corinna,
> >Have either of you considered adding code to cygcheck to check for more
> >common ntsec "problems"?  At the very least, something along the lines
> >of "your username isn't in /etc/passwd" seems like it would be
> >worthwhile.
>
> Chris,
>
> I have though about that and actually have such a program. However it's
> a Cygwin program. The idea being that it should reproduce *exactly* the
> starting sequence of Cygwin, which has varied over the years. Keeping
> cygcheck up to date might be a pain
>
> In the patch I have just sent, the group name is set to "run mkpasswd"
> if the username is not in passwd, and it is "run mkgroup" if the user name
> is present but not his group.
> So that should be clearly visible in "id", and visible but truncated in
> "ls -l".

Pierre,

IMHO, "No entry" is a better name for such a situation ([ug]id=3D=3D-1).  It
could then be documented in the FAQ.  Just my 2=A2...

> I have also changed the default uid and gid to 400/401 when the names are
> missing, to make detection easy. It can then easily be done e.g. in
> /etc/profile or in sshd-user-config.
>
> The question of "Why is my HOME C:\ " could also be handled in /etc/profi=
le.
> I was thinking of putting something like this in it:
> echo "Hello this is /etc/profile"
> echo "You are a new user and I will verify your configuration".
> echo "Delete these lines once everything is well".
> if [ $uid -eq 400 ]; then etc...
> echo "Your HOME is set to $HOME, the rules are 1).. 2).. 3).. 4).. "
>
> What do you think?
>
> Pierre

How about just "Warning: HOME set to 'C:\', check your /etc/passwd or the
value of HOME in the Windows environment"?  An advanced user (or one who
simply wants to set his home to 'C:\') should be able to just comment out
this warning from /etc/profile, right?
	Igor
--=20
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

Oh, boy, virtual memory! Now I'm gonna make myself a really *big* RAMdisk!
  -- /usr/games/fortune
