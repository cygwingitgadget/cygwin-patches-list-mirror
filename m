Return-Path: <cygwin-patches-return-9862-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 56890 invoked by alias); 14 Dec 2019 18:38:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 56880 invoked by uid 89); 14 Dec 2019 18:38:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=H*Ad:U*cygwin-patches, COM, Generic, scanner
X-HELO: vsmx009.vodafonemail.xion.oxcs.net
Received: from vsmx009.vodafonemail.xion.oxcs.net (HELO vsmx009.vodafonemail.xion.oxcs.net) (153.92.174.87) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 14 Dec 2019 18:38:42 +0000
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id CDC46159D8EF	for <cygwin-patches@cygwin.com>; Sat, 14 Dec 2019 18:38:39 +0000 (UTC)
Received: from Gertrud (unknown [91.47.60.226])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id A3432159D869	for <cygwin-patches@cygwin.com>; Sat, 14 Dec 2019 18:38:37 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Provide more COM devices
References: <87mudvwnrl.fsf@Rainer.invalid>	<20191021081844.GH16240@calimero.vinschen.de>	<87pniq7yvm.fsf@Rainer.invalid>	<20191022071622.GM16240@calimero.vinschen.de>	<87sgn4ai3n.fsf@Rainer.invalid>
Date: Sat, 14 Dec 2019 18:38:00 -0000
In-Reply-To: <87sgn4ai3n.fsf@Rainer.invalid> (Achim Gratz's message of "Sun,	03 Nov 2019 20:13:32 +0100")
Message-ID: <871rt6rbvb.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SW-Source: 2019-q4/txt/msg00133.txt.bz2

Achim Gratz writes:
> Corinna Vinschen writes:
> [=E2=80=A6]
>> ttyS%(0-255) takes another 23K btw.  Even that should be ok, if
>> the need arises.  Alternatively we could shortcut shilka as for
>> /dev/sd*, but that involved much bigger numbers.
>
> I've searched for some documentation (anywhere the glob syntax %(1-128)
> would turn up, btw?) and I think Cygwin is misusing shilka a bit here.
> It's a keyword scanner, so the arithmetically coded parts of the device
> shouldn't be targeted at all.  Instead, only the device path prefix
> should be searched via the shilka lexer and the rest of the conversion
> done in code.

I've stared at the code for quite some time now and I think I've come up
with something that could work.  I'm chopping the device numbers and
disk names off the end of the device name before feeding into the shilka
lexer.  That creates a lexer with only 29 keywords and much less entries
in the dev_storage array, so it should be much faster to search also,
although I think a hash to access the array via the major device number
would now be feasible.  I think I'll have to extend the _device
structure with one or two more function pointers to deal with putting
the minor numbers back in before handing the result to the caller.  In
principle that could deal with any number of devices that fit into the
device number scheme, but we can still declare certain ranges illegal.

--8<---------------cut here---------------start------------->8---
void
device::parse (const char *s)
{
  size_t len =3D strlen (s);
  const char *t =3D s + len; /* points past s */

  /* chop off any trailing digits and leave t pointing to the beginning of =
that number */
  for (; isdigit (t-1); len--, t--) ;

  if (len > 7 && len < 12 && s[7] =3D=3D 'd'
      /* Generic check for /dev/sd[a-z] prefix */
      && strncmp (s, DISK_PREFIX, DP_LEN) =3D=3D 0
      && s[DP_LEN] >=3D 'a' && s[DP_LEN] <=3D 'z')
    {
      /* /dev/sd* devices have 8192 entries, given that we support 128 disks
	 with up to 64 partitions.  Handling them with shilka raises the size
	 of devices.o from ~250K to ~2 Megs.  So we handle them here manually
	 to save this space. */
         =E2=80=A6
    }
  else
    {
      const _device *dev =3D KR_find_keyword (s, len);
      if (!dev)
	*this =3D *fs_dev;
      else
	{
	  *this =3D *dev;
	  /* check and process device numbers */
          =E2=80=A6
	}
    }
}
--8<---------------cut here---------------end--------------->8---


Regards,
Achim.
--=20
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf Q+, Q and microQ:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds
