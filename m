From: Egor Duda <deo@logos-m.ru>
To: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: Console codepage
Date: Wed, 07 Feb 2001 07:08:00 -0000
Message-id: <150109183687.20010207180613@logos-m.ru>
References: <u7l3fv26h.fsf@mail.epost.de> <20010128154852.A20701@redhat.com> <s1sitmu890d.fsf@jaist.ac.jp>
X-SW-Source: 2001-q1/msg00054.html

Hi!

Thursday, 01 February, 2001 Kazuhiro Fujieda fujieda@jaist.ac.jp wrote:

>>>> On Sun, 28 Jan 2001 15:48:52 -0500
>>>> Christopher Faylor <cgf@redhat.com> said:

>> I can't comment on the validity of the patch itself.  I hope that Egor
>> or Kazuhiro will do that.

KF> His patch seems fine to me except for its potential overhead.
KF> I'm afraid the overhead becomes sensible on cheap Win9x boxes.
KF> Console APIs are generally slower on 9x than on NT/2000.
KF> Anyway, I believe his patch is essential for users using 8bit
KF> characters.

this  patch  works ok for me, too. i don't think that it will lead  to
performance  degradation,  though. i believe that console api on 9x is
slow   not  because  of char<->unicode translation, but because of the
way WriteFile() API works on consoles.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

