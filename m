From: egor duda <deo@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: storing symlink in extended attribute (on ntfs)
Date: Tue, 29 May 2001 23:50:00 -0000
Message-id: <13839205033.20010530104808@logos-m.ru>
References: <1791875116.20010510172000@logos-m.ru> <12912395994.20010510201521@logos-m.ru> <20010511142639.A26920@redhat.com> <64168820861.20010512154228@logos-m.ru> <178350282529.20010514180653@logos-m.ru> <18289228183.20010524164714@logos-m.ru> <20010529214139.B14906@redhat.com>
X-SW-Source: 2001-q2/msg00269.html

Hi!

Wednesday, 30 May, 2001 Christopher Faylor cgf@redhat.com wrote:

CF> I'm having some reservations about this.  Doesn't this essentially add a
CF> third method for dealing with symlinks on NT?  I know that there are
CF> benefits to your method but I wonder if we really want to go down
CF> this road.

i strongly hope that semantically this method is backward- and
forward-compatible with current situation. it's even bug-compatible
(one shouldn't mess with symlinks with native tools).

actually, it's more of addition to .lnk method rather than a new one.
one can think of it as if Corinna have had changed her code to append
some additional data to .lnk file. with my addition, this data is
simply held in EA, not in file itself.

the only problem with it i know of is a small slowdown in symlink
resolution on samba drives which expose themselves as NTFS ones, while
not being them.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

