Return-Path: <cygwin-patches-return-7521-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18858 invoked by alias); 9 Oct 2011 10:31:33 -0000
Received: (qmail 18803 invoked by uid 22791); 9 Oct 2011 10:31:32 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-vx0-f171.google.com (HELO mail-vx0-f171.google.com) (209.85.220.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 09 Oct 2011 10:31:12 +0000
Received: by vcbfo13 with SMTP id fo13so5216159vcb.2        for <cygwin-patches@cygwin.com>; Sun, 09 Oct 2011 03:31:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.52.115.74 with SMTP id jm10mr9197891vdb.40.1318156271396; Sun, 09 Oct 2011 03:31:11 -0700 (PDT)
Received: by 10.52.187.161 with HTTP; Sun, 9 Oct 2011 03:31:11 -0700 (PDT)
In-Reply-To: <20111008150338.GA3189@calimero.vinschen.de>
References: <CAHWeT-ar0PNJ83P64iKOZq9f-AmjzsAqA9J=BHW_M24=URbKEg@mail.gmail.com>	<20111008150338.GA3189@calimero.vinschen.de>
Date: Sun, 09 Oct 2011 10:31:00 -0000
Message-ID: <CAHWeT-a1d2uGQNGmspRdqGOuTBNerv3g90zLwJW23n_UadV=GA@mail.gmail.com>
Subject: Re: Add locale.exe option for querying Windows UI languages
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
X-SW-Source: 2011-q4/txt/msg00011.txt.bz2

On 8 October 2011 16:03, Corinna Vinschen wrote:
>
> On Oct =C2=A08 10:24, Andy Koppe wrote:
>> The attached patch adds a --interface/-i option to locale.exe that
>> makes the --system/-s and --user/-u options print the respective
>> default UI language instead of the default locale.
>>
>> =C2=A0 =C2=A0 =C2=A0 * locale.cc: Add --interface option for printing Wi=
ndows default UI
>> =C2=A0 =C2=A0 =C2=A0 languages.
>>
>> For background, here's what Windows' various default locales and languag=
es do:
>>
>> - LOCALE_USER_DEFAULT: This reflects the setting on the Formats tab of
>> the (Windows 7) Region&Language control panel, which affects the
>> format of times, dates, numbers, and currency.
>>
>> - LOCALE_SYSTEM_DEFAULT: This reflects the "Language for non-Unicode
>> programs" on the Adminstrative tab of Region&Language control panel,
>> which also determines the ANSI and OEM codepages.
>>
>> - GetUserDefaultUILanguage(): This is the current user's Windows UI
>> language, also called display language. On Windows installs with
>> multiple UI languages, a setting for this appears on the "Keyboards
>> and Languages" tab of the Region&Language control panel.
>>
>> - GetSystemDefaultUILanguage(): The is the system-wide UI language
>> used for things that aren't user-specific, e.g. the login screen. As
>> far as I know it's determined at Windows install time and can''t be
>> changed.
>
> I like the idea of the patch, but I'm wondering if this is the right
> approach. =C2=A0I wasn't aware of the difference between the LOCALE_FOO_D=
EFAULT
> values and what the GetFooDefaultUILanguage functions return, otherwise
> I would have probably used the GetFooDefaultUILanguage functions right fr=
om
> the start.
>
> What I mean is this. =C2=A0The locale -u/-s functionality was supposed to=
 be
> used to set the $LANG value preferredly. =C2=A0Since LANG means language =
in
> the first place, the UI language is a much more natural choice for the
> default -s/-u functionality, isn't it?

Makes sense.

> Therefore, afaics, it would be better if we change locale to use the
> GetFooDefaultUILanguage functions by default, and we add a modifier
> (-r/--region?) to switch to LOCALE_FOO_DEFAULT.
>
> Either way, the usage output will have to be improved.  Maybe we should
> explicitely state that the values printed refer to the Windows values,
> and that one of them is the UI locale and the other is the... hmm...
> how to say it..., maybe the "region settings locale" or so.

How about having one option for each of the Windows settings, and
dividing the help output into groups, like so:

POSIX locale options:
  -a, --all-locales    List all available supported locales
  -c, --category-name  List information about given category NAME
  -k, --keyword-name   Print information about given keyword NAME
  -m, --charmaps       List all available character maps

Windows locale options:
  -u, --user-lang      Print user default UI language
  -s, --system-lang    Print system default UI language
  -f, --format         Print user format setting for times, numbers & curre=
ncy
  -n, --non-unicode    Print system locale for non-Unicode programs
  -U, --utf            Attach ".UTF-8" to the result

Other options:
  -v, --verbose        More verbose output
  -h, --help           This text


>> Looking at those, and if we wanted to base the Cygwin locale settings
>> on the Windows ones, I think LC_NUMERIC, LC_TIME, and LC_MONETARY
>> should be determined by LOCALE_USER_DEFAULT, but LC_MESSAGES should be
>> determined by GetUserDefaultUILanguage(). Not sure about LC_CTYPE and
>> LC_COLLATE, but I suppose it would make sense for character
>> classification and sorting to match the UI language.
>
> The system should not set the LC_xxx values at all. =C2=A0From my POV the
> system should only default to some $LANG, while setting the LC_xxx
> values is the job of the user if the $LANG value doesn't suffice.

Not sure about that, but it's not really worth discussing unless we do
decide to follow the Windows setting(s) by default.

Andy
