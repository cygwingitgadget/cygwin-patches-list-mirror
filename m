Return-Path: <SRS0=PtZj=BA=towo.net=towo@sourceware.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	by sourceware.org (Postfix) with ESMTPS id D35254BA2E08
	for <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 13:19:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D35254BA2E08
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=towo.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=towo.net
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D35254BA2E08
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=217.72.192.75
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772284772; cv=none;
	b=L6fHDhDUPoRouEWyYW1O/z5GRHdubUhBTfG7PHHFfV+shNqL5ZgdqKyMj+5jfX4Kek6LXFPeyBiIe1ypKDuTSLY4URoYr/jE/xNpl4r4aYydViKV/kVr6Uusv6yqlZ/TuqNiuaNabcgUa/lgfoZfw9tUKtOrG6r++UbvdlLDZnA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772284772; c=relaxed/simple;
	bh=DpZYlt/u4oVtrN2GC9AC24ymoY6FvaapTG6qJyJg4P8=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From; b=I0GMda6W0n8zODAdAa7B596idLFPUz4mqEvhY3HlX8Fp/RzH/bkz4B9w/Ob/qwELdslbFcCBVMDLaiqrRgGykp1tbiLzJo9liof0aAWBkbjFkdQNDhJYNlPadriscqebFCyOHS6lX/At0W7330cK1kUktWBTU44zF8ID/OFtwT8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D35254BA2E08
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=towo.net header.i=towo@towo.net header.a=rsa-sha256 header.s=s1-ionos header.b=ywAefBMJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=towo.net;
	s=s1-ionos; t=1772284770; x=1772889570; i=towo@towo.net;
	bh=Xz9w9yzMK6ByAuaoi+orf6EgxkdK1fU6gZ/zx2Tuxco=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ywAefBMJWqq9N5n07GoKPhnE+uvo3JpOlK6xrgILiYz6sJVxKu+LHxdWp9OJBeuX
	 0uDJl4tUysiMqK8/mF5STMKFb356CnyddrZI31SFBlhdSVZEZd1N5z/cqCaC/esRV
	 iODa3CdQIyi5KUDomm9xtPnc4Osh8JSacgP1tFWp561bRYlhM/vhoSRz0a8gDSSrr
	 tlFwz+Bhvs/Iz1yTD1bwkkQ7HnXOASa00bPGcLH/vpOdu5SYB2hDCzp357TWywo5l
	 J56DPToXnK3CrQKyUJAemk//kYlltK42Qxj1sSHbL5ib/YIoWKJayKYp+hvBtbREf
	 aDL3s3vb91IGHMzDDw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M4rD7-1vx9RV10bP-00GxeP for
 <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 14:19:30 +0100
Message-ID: <0a2f7645-9bee-4b99-a0a8-dd6552ee5dfb@towo.net>
Date: Sat, 28 Feb 2026 14:19:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: pty: Improve CSI6n handling in pcon_start state
To: cygwin-patches@cygwin.com
References: <20260223080106.330-1-takashi.yano@nifty.ne.jp>
 <00548c9e-dd25-40e9-737a-4113910d4c8f@gmx.de>
From: Thomas Wolff <towo@towo.net>
Autocrypt: addr=towo@towo.net; keydata=
 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 kQ==
In-Reply-To: <00548c9e-dd25-40e9-737a-4113910d4c8f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OxEnwiMhbbHHgGRlycxq0Z3ZC45u58Lvcja4ax3SAorFXQl4sNQ
 XsJDaDvcXTwqOUDFgyUel3USVopP+px5qJGk1WA4z6Ohxz3KFBukUdLI7UV6v61A+6Dk48U
 d6FnVHOaWOcqJ04YIoMNZ7KsXNfQVnBG3ZS5XUnC4CabiiL0+7zlZv7SH9YqxTbLHv8gf9C
 fxIrQt6kM9EwOxU6NtVrw==
UI-OutboundReport: notjunk:1;M01:P0:sDDVAHXl9eo=;ZJKX+E9dCi5LQZBTJCLD4t3hkcW
 yfTpkBKNew88YaINo2auljtmbOygvGXCy4dwpMsoIFNMWAw7XVMvXfnk8/ByLrH+WLrYwfp9o
 aAuE/JjHQBMAPAK6Y7x+YS/37HqGH8J288XbZX/yBOK5Y1UP8j5rGVluHDbkEkYhqoOurOIk3
 kHSmVKsS4akT9L9+PERjHHUW0XsUNl9ibPxOa5jmIKXdAcvZAdbul2FBMzJYFHWOq6JDGSIEr
 f8xIRCoWw6YCqP5kb7GolvL/yjc2QST63FIKsw+1PiPVojS0MR37vDUxHOeX9WQQURRKDp1+q
 luUU7xu4ln2xULrMjFY/DbOytSJzATGLHprrGN3QVU4Dnm54HQxMQqvKf1/kAKeb7EuvEYm64
 CSUUYTmNVXW8a8bVWDgr9ha2MUZtC61sXWSq0KaTE7TTHUvaI4au3E7LfqZoBat65hs5O8ldx
 mVgvh01O1SFd0GB7kuXw8xEP8KLzqzQI2pamt+v4yQEicR4Zmm6OsgktSXwl1HdG645c5FtzL
 2tsETmAtAE/AnI2k0Zy1SjrqkPFmWtlsEf1Swfa2TOQpafh/Wj6rAj4/wqSS/ZxMaZHFs6yhr
 UC1mqz0XXoKbWAv2x4fvpmVkCHJU3AcK2ft/f8H2zQdYJf4x+QjtB8wf82LKlHVWln5EwoD08
 WpgPFEdcf6wOE8pplRNn+W5SocZvNFUgnfQdMXaPrNZWgGOCYJPKU0USwu0DDkUG4VLlffyGK
 1eqN18cRe06fyeJY5muaf8KNiZrCUT0tOdBW/1MgwJkbM5E8oZbkb27yNPHj6T4TWRmZYCdQ/
 2kmrUyRlQ+CY3mpv0Wvts3bXx3OzYpHqCJA011U5zkpPArrPJ+oIGDlvN2qfZUijqDj08ZuWE
 1J42QrMZoJzO35lIYkpdLyCH070CW3DLX+JdJI+UJkR89aRnK5MrNhX0UaCK0QUXuenR4HllT
 vxro3j7WKpLfYTV+u/V2LdnPjuhyzipronYPfDiVSB+XerSU+isiD9WmcGrpmrprUTPEmkNzi
 eXKMZh3jz7+ytSvlhtnMTJ9XSV311BWsP0R+Zh5GJOuybUO0VKwZxJ8KOgYTq+7gd159Kf7mk
 XZi1GJQkWZF0RWn2CLukPBuI7jj2E/izmCG/moODHpPoNrAGcREhh6+tsroRH4s0wBZHl1YxQ
 8apoaKroH6ZO9l04r4dN1ztjuybYEvM3WJCf1ES+IqgKcv41kwqLcEx77ELO+BsQ4KAfoJS3k
 blE3hdSljse2TIUiy69XqYLn8mGtBVo8LlzKjoRiNtw3gGJuShGAIdZWkQ4fL2YSmJG3dVLfT
 odX5RMJPTN/KZPmB9uhxEwpjbxpSv9cp3RXiRZxbQ8TEkgPyDg/UyZdhfNumvRrerVLCycDt8
 6kHimZhzfjifiDF9Ql8dqMNP3s7nxfAJeSG87iWv7U946PY1Q1t9wITv4/6qHQz4n0oSEGd8h
 7k4xcAKilye+vhYObfpbLHHM0MMyRB3/q5Vei+38QRdWFKtJ8aznPFmcpXBoLHP0ZWDkENi+x
 0qn4BlYgIIKe3VT37jyfugp3xYH7SQBqowxfMCy0XVoPd7Y//bp2v086+q4MKtMdx+lQWxEQM
 zwggJ+fvY8dDIAggSdzI0+9V/Qtr3l0Cnekr7D5OHZ98lJfxsvSiz7899IxsHXtRaCIq0vL1k
 zkCJ78ZKWpmpdEjrGCMZTJdduwZDnUEgAuy4pfNIOtbacRsMQ1d4yL6U7uGwDrMCM=
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>


Am 27.02.2026 um 18:58 schrieb Johannes Schindelin:
> Hi Takashi,
>
> On Mon, 23 Feb 2026, Takashi Yano wrote:
>
>> Previsouly, CSI6n was not handled correctly if the some sequences
>> are appended after the responce for CSI6n. Especially, if the
>> appended sequence is a ESC sequence, which is longer than the
>> expected maximum length of the CSI6n responce, the sequence will
>> not be written atomically. With this patch, pcon_start state
>> is cleared at the end of CSI6n responce, and appended sequence
>> will be written outside of the CSI&n handling block.
I encounter stray CSI6n when I invoke wsl.exe via execl(p) within a=20
forkpty child and I was puzzled why that occurs.
Could it be related to this issue (and hopefully fixed by the patch)?
Thomas

> The idea of breaking out of the CSI 6n loop at `R` and falling through t=
o
> the normal write paths is sound, but I think the `towrite` accounting ha=
s
> a bug, and the commit message could use some work.
>
>> Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
>> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
>> Reviewed-by:
>> ---
>>   winsup/cygwin/fhandler/pty.cc | 20 +++++++++++++-------
>>   1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty=
.cc
>> index 838be4a2b..c1e03db41 100644
>> --- a/winsup/cygwin/fhandler/pty.cc
>> +++ b/winsup/cygwin/fhandler/pty.cc
>> @@ -2137,6 +2137,8 @@ fhandler_pty_master::close (int flag)
>>   ssize_t
>>   fhandler_pty_master::write (const void *ptr, size_t len)
>>   {
>> +  size_t towrite =3D len;
>> +
>>     ssize_t ret;
>>     char *p =3D (char *) ptr;
>>     termios &ti =3D tc ()->ti;
>> @@ -2171,6 +2173,8 @@ fhandler_pty_master::write (const void *ptr, size=
_t len)
>>   	    }
>>   	  if (state =3D=3D 1)
>>   	    {
>> +	      towrite--;
>> +	      ptr =3D p + i + 1;
> The per-byte `towrite--` only fires inside `state =3D=3D 1`, so bytes be=
fore
> the ESC (which go through the `else` / `line_edit` branch) are never
> subtracted. If there happen to be N bytes before the ESC in the same
> write, `towrite` ends up N too large, and the `nat` pipe fast path reads
> past the end of the buffer.
>
> This can be fixed in a simpler way by not tracking `towrite` in the loop
> at all, and instead computing it once at the break, see below...
>
>>   	      if (ixput < wpbuf_len)
>>   		wpbuf[ixput++] =3D p[i];
>>   	      else
>> @@ -2184,7 +2188,10 @@ fhandler_pty_master::write (const void *ptr, siz=
e_t len)
>>   	  else
>>   	    line_edit (p + i, 1, ti, &ret);
>>   	  if (state =3D=3D 1 && p[i] =3D=3D 'R')
>> -	    state =3D 2;
>> +	    {
>> +	      state =3D 2;
>> +	      break;
>> +	    }
>
> If you initialize `towrite =3D 0` and make this hunk look like this inst=
ead:
>
> 	  if (state =3D=3D 1 && p[i] =3D=3D 'R')
> -	    state =3D 2;
> +	    {
> +	      state =3D 2;
> +	      towrite =3D len - i - 1;
> +	      ptr =3D p + i + 1;
> +	      break;
> +	    }
>
> then no per-byte bookkeeping is needed, making the entire logic a lot mo=
re
> robust, not to mention: easier on the reader's brain.
>
> Regarding the commit message: beyond the typos ("Previsouly" =3D>
> "Previously", "responce" =3D> "response" x3, "CSI&n" =3D> "CSI 6n"), the=
 body
> describes the bug as "the sequence will not be written atomically", but
> isn't the actual problem that bytes after the `R` terminator go through
> per-byte `line_edit` inside the CSI 6n loop and then hit `return len`
> without ever reaching the `nat` pipe fast path? In that case, it would b=
e
> a routing problem, not an atomicity problem, and something like:
>
>      Cygwin: pty: Fix data after CSI 6n response bypassing normal write =
paths
>
>      When the terminal's CSI 6n response and subsequent data (e.g.
>      keystrokes) arrive in the same write buffer, `master::write()`
>      processes all of it inside the pcon_start loop and returns early.
>      Bytes after the 'R' terminator go through per-byte `line_edit()` in
>      that loop instead of falling through to the `nat` pipe fast path or
>      the normal bulk `line_edit()` call.
>
>      Fix this by breaking out of the loop when 'R' is found and letting =
the
>      remaining data fall through to the normal write paths, which are no=
w
>      reachable because `pcon_start` has been cleared.
>
> would be potentially more accurate in describing what is going on.
>
> I am still quite fuzzy on the exact goings-on in the pty code, essential=
ly
> cobbling it all together "on the side" because I unfortunately cannot
> afford to spend much focus on the Cygwin/MSYS2 runtime. Hopefully what I
> said above makes some sense?
>
> Ciao,
> Johannes
>
>>   	}
>>         if (state =3D=3D 2)
>>   	{
>> @@ -2220,8 +2227,8 @@ fhandler_pty_master::write (const void *ptr, size=
_t len)
>>   	    }
>>   	  get_ttyp ()->pcon_start_pid =3D 0;
>>   	}
>> -
>> -      return len;
>> +      if (towrite =3D=3D 0)
>> +	return len;
>>       }
>>  =20
>>     /* Write terminal input to to_slave_nat pipe instead of output_hand=
le
>> @@ -2233,15 +2240,14 @@ fhandler_pty_master::write (const void *ptr, si=
ze_t len)
>>   	 is activated. */
>>         tmp_pathbuf tp;
>>         char *buf =3D (char *) ptr;
>> -      size_t nlen =3D len;
>> +      size_t nlen =3D towrite;
>>         if (get_ttyp ()->term_code_page !=3D CP_UTF8)
>>   	{
>>   	  static mbstate_t mbp;
>>   	  buf =3D tp.c_get ();
>>   	  nlen =3D NT_MAX_PATH;
>> -	  convert_mb_str (CP_UTF8, buf, &nlen,
>> -			  get_ttyp ()->term_code_page, (const char *) ptr, len,
>> -			  &mbp);
>> +	  convert_mb_str (CP_UTF8, buf, &nlen, get_ttyp ()->term_code_page,
>> +			  (const char *) ptr, towrite, &mbp);
>>   	}
>>  =20
>>         for (size_t i =3D 0; i < nlen; i++)
>> --=20
>> 2.51.0
>>
>>

