From: Christopher Faylor <cgf@redhat.com>
To: cygwin-developers@cygwin.com, cygwin-patches@cygwin.com
Subject: Re: hierarchy in setup (category stuff)
Date: Fri, 29 Jun 2001 17:56:00 -0000
Message-id: <20010629205735.K9607@redhat.com>
References: <04e801c0faa2$f9008260$0200a8c0@lifelesswks> <20010621222615.C13746@redhat.com> <3B3324A7.49FFC98A@yahoo.com> <054c01c0fbef$5f600e20$0200a8c0@lifelesswks> <06a001c0fc51$7a87e210$0200a8c0@lifelesswks> <20010629114004.A6990@redhat.com> <VA.00000842.01fd0b44@thesoftwaresource.com> <20010629172912.A8991@redhat.com> <032001c100fe$d62310c0$806410ac@local>
X-SW-Source: 2001-q2/msg00370.html

On Sat, Jun 30, 2001 at 10:51:44AM +1000, Robert Collins wrote:
>> Either way, there would still be problems.  I think that they are mainly
>because
>> of Michael's white space fixes.
>>
>> I sometimes wish that we had a C/C++ aware version of patch.
>
>My .2c: update your CVS server. I have much much less problems with merges
>with the sourceforge CVS server.

I was using patch, actually.  I don't know how CVS would affect this.

But, I do want to update the server.  It's been patched locally, so I'm really
reluctant to tackle this but I really really should do this.

>> >> Robert, if you are still interested, then I think that this is
>definitely the
>> >> way to go.  If you have something worth checking in, then please do so.
>
>I'll draw up change log stuff and send something to cygwin-patches... or did
>you want me to hit CVS directly?

Go ahead and check it in.  We can tweak it later.

>>I'm thinking that we should just nuke the "latest" and "contrib"
>>directories and create directories based on the name of the categories.
>
>I don't think we even need separate directories - they don't do much
>once the package system manages the view :].

I was just thinking of using the directories as an organizational method
for the packages on sourceware.  The alternative is to somehow get the
information into the setup.hint file there or to add some other file to
the directory.  That's a lot of work and it's error-prone.  I can easily
foresee erroneously having a Development and a Devlopment (misspelled)
category if we do this on a per-package basis.

As far as the layout on the user's side, I don't really care, except
that we could almost forgo setup.ini completely and just rely on the
directory layout for "Install From Current Directory".

The next thing we have to do is add descriptions.  That will involve
another chooser change.

cgf
