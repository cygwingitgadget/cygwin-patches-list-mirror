Return-Path: <cygwin-patches-return-1940-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30793 invoked by alias); 2 Mar 2002 03:03:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30769 invoked from network); 2 Mar 2002 03:03:51 -0000
Date: Sun, 03 Mar 2002 21:18:00 -0000
From: Christopher Faylor <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: automatic TZ env-variable in localtime "problem" with W2000-germa n
Message-ID: <20020302030343.GA15369@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BDF28C498CFED4119D720002B330B89301200A7A@xhole.bre.de.adp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BDF28C498CFED4119D720002B330B89301200A7A@xhole.bre.de.adp.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00297.txt.bz2

This is not a patch.

You'd be well-advised to peruse past messages in this mailing list and
also look at the Contributing link of the cygwin web page so that you
can see how this is supposed to be done.

Who knows?  Your rebuild problems might actually be mentioned in the
archives, too.

cgf

On Wed, Feb 27, 2002 at 06:35:05PM +0100, Markus K. E. Kommant wrote:
>Hello,
>I have the following problem, or misunderstandig(!) of TZ variable in
>cygwin1.dll.
>
>Problem (and my current solution)
>
>When I do not set TZ to a valid value, all times will be showed as GMT (or
>UTC) time.
>The automatic generated TZ variable in localtime.cc will generate a name
>from GetTimeZoneInformation.
>
>When I test this algorithm in a program, the name will be invalid (longer
>than 3 characters).
>
>At the moment I have problems to rebuild the cygwin1.dll (make will make a
>lot of things but I do find a simple make cygwin1.dll...)
>
>Is it a good, bad, very bad idea to test the length of the name against 3 to
>generate a TZ variable compatible with tzparse?
>
>
>localtime.cc (not tested, because I was not able to build cygwin1.dll)
>
>	    GetTimeZoneInformation(&tz);
>(...)
>	    for (src = tz.StandardName; *src; src++)
>	      if (is_upper(*src)) *dst++ = *src;
>
>	    /* not 3 characters for timezone _tzname[0] ? 
>               happens for example in Win2000/NT german version
>               a) tz.StandardName is a WideChar String
>               b) is very long "Westeropaische Normalzeit"
>               generate a TZ variable relative to GMT-x
>               (if strlen of _tzname is not equal 3 , tzparse will 
>                not accept the TZ variable!)
>               mkt */
>            if (strlen(cp) != 3)            /* mkt */
>            {                               /* mkt */
>               strcpy(cp, "GMT");           /* mkt */
>               dst = cp + 3;                /* mkt */
>            }                               /* mkt */
>
>(...) same for the daylight saving time with DST.
>
>When I call this function as a separate routine win32_tzset (roughly written
>in win32_tzset.c for my VC program and Cygwin-GNU ports) the TZ variable
>will be understood and the correct times will be chown.
>
>pdksh port with a call to win32_tzset to set TZ automatically from Windows
>Control Panel:
>pdksh $ echo $TZ
>GMT-1DST-2,M3.5.0/2,M10.5.0/3
>pdksh $ date
>Mon Feb 11 17:35:54  2002
>(yes this the current time)
>
>bash-2.05a$ date
>Mon Feb 11 16:36:25  2002
>(no, this the UTC time)
