Return-Path: <cygwin-patches-return-6818-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12098 invoked by alias); 7 Nov 2009 11:50:08 -0000
Received: (qmail 12083 invoked by uid 22791); 7 Nov 2009 11:50:06 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0 	tests=AWL,BAYES_00,SARE_MSGID_LONG40,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-qy0-f199.google.com (HELO mail-qy0-f199.google.com) (209.85.221.199)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 07 Nov 2009 11:50:01 +0000
Received: by qyk37 with SMTP id 37so712445qyk.18         for <cygwin-patches@cygwin.com>; Sat, 07 Nov 2009 03:49:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.229.111.195 with SMTP id t3mr819901qcp.44.1257594599646; Sat,  	07 Nov 2009 03:49:59 -0800 (PST)
In-Reply-To: <20091107100807.GA14099@calimero.vinschen.de>
References: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de> 	 <416096c60911061355vac592d4y4c76435689301aad@mail.gmail.com> 	 <20091107100807.GA14099@calimero.vinschen.de>
Date: Sat, 07 Nov 2009 11:50:00 -0000
Message-ID: <416096c60911070349w5d132ad0i73b3f3b930dff578@mail.gmail.com>
Subject: Re: console enhancements: mouse events
From: Andy Koppe <andy.koppe@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00149.txt.bz2

2009/11/7 Corinna Vinschen:
>> Mintty roughly does the following for Ctrl(+Shift)+symbol combinations:
>> - obtain the keymap using GetKeyboardState()
>> - set the state of the Ctrl key to released
>> - invoke ToUnicode() to get the character code according to the keyboard=
 layout
>> - if the character code is one of [\]_^? send the corresponding control =
code
>> - otherwise, set the state of both Ctrl and Alt to pressed (this is
>> equivalent to AltGr), and try ToUnicode() again
>>
>> The last step means that e.g. Ctrl+9 on a German keyboard will send
>> ^]. The proper combination would be Ctrl+AltGr+9, but since
>> AltGr=3D=3DCtrl+Alt, that can't be distinguished from AltGr+9 without
>> Ctrl. (Well, not without somewhat dodgy trickery anyway.)
>
> How does that work for ^^? =C2=A0The ^ key is a deadkey on the german key=
board
> layout, so the actual char value is only generated after pressing the key
> twice. =C2=A0Just curious.

ToUnicode actually delivers the ^ character right away when pressing
the key, but with return value -1 to signify that it's a dead key and
that the next key will be modified accordingly. So for Ctrl+^, mintty
sends ^^ right away and then clears the dead key state using a trick
picked up from http://blogs.msdn.com/michkap/archive/2006/04/06/569632.aspx:
feed VK_DECIMALs into ToUnicode until it stops returning dead-key
characters.

(Yep, it's a terrible API for an unintuitive feature. See also
http://blogs.msdn.com/michkap/archive/2005/01/19/355870.aspx)

Andy
