Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 9E8DB3857414
 for <cygwin-patches@cygwin.com>; Fri, 29 Jul 2022 18:34:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9E8DB3857414
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M1ZUb-1oKWjT2s15-0034f5; Fri, 29 Jul 2022 20:28:56 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E708DA80B8C; Fri, 29 Jul 2022 20:28:55 +0200 (CEST)
Date: Fri, 29 Jul 2022 20:28:55 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jon Turney <jturney@sourceware.org>
Cc: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [newlib-cygwin] Cygwin: Set threadnames with
 SetThreadDescription()
Message-ID: <YuQm5xcBC+1LJSJk@calimero.vinschen.de>
Mail-Followup-To: Jon Turney <jturney@sourceware.org>,
 Cygwin Patches <cygwin-patches@cygwin.com>
References: <20220729110147.4E6F43858424@sourceware.org>
 <YuPLd2hlbaNwxAJ0@calimero.vinschen.de>
 <78af80e5-baed-5ebb-314f-99d13f2a25ca@sourceware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78af80e5-baed-5ebb-314f-99d13f2a25ca@sourceware.org>
X-Provags-ID: V03:K1:FhbLTcuPJ16+k8j7fDtX4MJkWgS4QUR02H9E7K8B9kR7zj3m09s
 i66dA/kVqUZgYKk9mNvMzgFxnjmPG/p9T2wz2TqobI0QUF2zGIRhZ61JI13kiznktppxnuQ
 39S2GyeEOWNm5lHy6jyLdVOGIT19PQyrEKl+bsmIf0P72V7sOPBtmKJkZDOguCNHBbM/B/E
 MKQWfRIdd67h2CFmf4ozA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q3aATduY6CI=:YI95GbRKMFpp5QI9aURaiK
 bO1y/WZQ9KvGBRvc0T1a0JhLzoZqyxwC8Vcw/mYoyocQ8LbZrJL2ldidhC7/bu0WDWekhBXH+
 RnF94tbtgHpAkahAkjvTqY6F0bffpOv+9mb2NiN478y1caIkCrwob2hh3c4jPqvnLZUm84Knx
 y257ze+Q292EG0mCPH5CltH30L/TDymSEmWgmG6BTYpMho5ttdooTDF3kAi0wAAz1/pXgVvnc
 LQgOrP+kV9vDWRlQVfj5NufP0RBk3r9l0SBC1ihg6CbBzq6ymQayeaGXYgzA7z8J8luj8f5XD
 xhDNQpteEjiIIV12irgtkn3OR1W5eNP3jmWcMKeKSmrBaFmJJPWHj4Gjbo0BNl4rQGkDBU/Lj
 jlbicO3L5CJG7aShds1No/eo1XgPL6VcX78S4GhoqJ8sNyOsLcqTe28ZrM27gXtE6OdSIo/H9
 8x6dN9AsyCyqPs6LcSt14Kodn9kIts/ReAHo3srG4PIvFo3quOf8fwXHeMzjuyWHbqFyaxITJ
 nOrMTi1TFhnVECjo733AJW4jWl+TK+NP9LF6it49kKfhLFZ8uCxUKDytddAASW+N+dTWS7JJM
 aaSaJlPinPCq9obWgVQEFt6fcJnsk0uf8bKI/OQ87xB0AwywiuJQ82VQFMiOlSyNVRrGVTOa1
 IMaCAx/DoFudZLXaYxCiKsNAPHl4svUq8d4k65flu5vsJ7LJr0XhruWgJnJuOP2dZI9oRGUwS
 bxRX/01fj1qwWzOYuIDv7+ZSHfOZ8fXNKVN+mTU7MZhe0BeaHLiGq+hSCnk=
X-Spam-Status: No, score=-95.6 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_FAIL, SPF_HELO_NONE,
 TXREP autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 29 Jul 2022 18:34:10 -0000

On Jul 29 15:14, Jon Turney wrote:
> On 29/07/2022 12:58, Corinna Vinschen wrote:
> > Hi Jon,
> > 
> > On Jul 29 11:01, Jon TURNEY via Cygwin-cvs wrote:
> > > https://sourceware.org/git/gitweb.cgi?p=newlib-cygwin.git;h=d4689b99c68628d9ec2fc1ac7884906ddbf6a2fc
> > > 
> > > commit d4689b99c68628d9ec2fc1ac7884906ddbf6a2fc
> > > Author: Jon Turney <jon.turney@dronecode.org.uk>
> > > Date:   Thu May 19 17:27:39 2022 +0100
> > > 
> > >      Cygwin: Set threadnames with SetThreadDescription()
> > >      [...]
> > > +      /* SetThreadDescription only exists in a wide-char version, so we must
> > > +	 convert threadname to wide-char.  The encoding of threadName is
> > > +	 unclear, so use UTF8 until we know better. */
> > > +      int bufsize = MultiByteToWideChar (CP_UTF8, 0, threadName, -1, NULL, 0);
> > > +      WCHAR buf[bufsize];
> > > +      bufsize = MultiByteToWideChar (CP_UTF8, 0, threadName, -1, buf, bufsize);
> > 
> > I think this is wrong.  The function should use stock mbstowcs instead
> > to get the externally used encoding.  Think of SetThreadName called with
> > program_invocation_short_name in pthread::thread_init_wrapper, or called
> > from pthread_setname_np with an externally provided thread name.  This
> > thread name will use the locale of the application code it's called by.
> 
> I'm not sure.
> 
> The linux manpage for pthread_setname_np() says "The thread name is a
> meaningful C language string", which I think means it's ASCII-encoded, not
> locale-encoded.

I think this only means, it's a NUL-terminated string. "Meaningful" is
just trying to nudge developers into using meaningful names, not
something like "blurb".

> (The solaris manpage explicitly says that the thread name is utf8 encoded)

Ok, that's an interesting point.

> The encoding for program_invocation_short_name was also unclear to me.
> (It's the same as argv[0], so I guess it's in whatever encoding the
> filesystem uses, which doesn't have to match the process locale encoding)
> 
> Expecting this function to work with non-ASCII names seems optimistic :)

Well, for Linux it's certainly just an arbitrary, NUL-terminated byte
stream, but yeah, it's certainly the only portable way to expect
the portable codeset.

Anyway, feel free to just keep the code as is.  We're typically using
UTF-8 anyway and people switching to one of the legacy codesets are
supposed to know what they are doing.


Corinna
