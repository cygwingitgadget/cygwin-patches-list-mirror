Return-Path: <cygwin-patches-return-8341-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 107192 invoked by alias); 19 Feb 2016 09:02:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 107169 invoked by uid 89); 19 Feb 2016 09:02:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1706, D*glup.org, interval, doctor
X-HELO: mail-wm0-f49.google.com
Received: from mail-wm0-f49.google.com (HELO mail-wm0-f49.google.com) (74.125.82.49) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Fri, 19 Feb 2016 09:02:20 +0000
Received: by mail-wm0-f49.google.com with SMTP id g62so65735719wme.1        for <cygwin-patches@cygwin.com>; Fri, 19 Feb 2016 01:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references         :subject:mime-version:content-transfer-encoding;        bh=9St7c5CI5/Oxm7Am3IFyOHXDHCAKGzG/1DSDDjtolBs=;        b=TF4EKQkjvG4w27I3LEwMyJ51xfNG0GUG9QIYj/iojDk5M2N3STIzK6hDUWKLIR9kdZ         0Cv1gtTJpgIXrjTQM/7y7gQ2HPhtmr6aX/UeWHui2vvGziCIR8Wdsi4oxhF3FIj9aqCQ         fT9kW2Dg8wy5w9MfhCz2QqVi0k3Q/vuxEMtqgEY7EkXTq3p+Cho9UEHOJe/ljpHslUrp         qe3r29xYpCiqMmPC7uNR1/FrQrlLqsPvzsUJ1lZuVQQha7YZSxb/RWhLrIcWNSyHTbH2         CAaHTv/RLjZmOF7vZwQcU9Pu3Aq/MxJuEe/MrDd+k8qsYkMXSizGksrteKq05WM51Ax7         aRlg==
X-Gm-Message-State: AG10YOQ9aGT9DZVjB0lrAX+kE4BdQ3pVIK5rG64zVt1kOlPNgM+B4ojkug/C/8/C4pB5pA==
X-Received: by 10.28.2.68 with SMTP id 65mr7531609wmc.85.1455872537545;        Fri, 19 Feb 2016 01:02:17 -0800 (PST)
Received: from 6472AC56.mobile.pool.telekom.hu (254C081B.nat.pool.telekom.hu. [37.76.8.27])        by smtp.gmail.com with ESMTPSA id a128sm6667140wmh.6.2016.02.19.01.02.14        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Fri, 19 Feb 2016 01:02:17 -0800 (PST)
Date: Fri, 19 Feb 2016 09:02:00 -0000
From: ikartur@gmail.com
To: cygwin-patches@cygwin.com,john hood <cgull@glup.org>
Message-ID: <a250a707-bf78-473b-a5a3-69b066ef9c6f.maildroid@localhost>
In-Reply-To: <56C67173.3030508@glup.org>
References: <CAJCedbifwNgza6nUfSX6QH8ovnEy85bRJ=vH8SGuA_hNYdW5bw@mail.gmail.com> <56C67173.3030508@glup.org>
Subject: Re: [PATCH] Multiple timer issues + new [PATCH]
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00047.txt.bz2

Hi,

On Feb 19, 2016 2:35 AM, "john hood" <cgull@glup.org> wrote:

> There's some information on the web discussing issues with
> QueryPerformanceCounter()

QueryPerformanceCounter() is the officially recommended method for time int=
erval measurements:

https://blogs.msdn.microsoft.com/oldnewthing/20140822-01/?p=3D163/

https://msdn.microsoft.com/en-us/library/windows/desktop/dn553408(v=3Dvs.85=
).aspx

Best Regards,
Art=C3=BAr

-----Original Message-----
From: john hood <cgull@glup.org>
To: cygwin-patches@cygwin.com
Sent: Fri, 19 Feb 2016 2:35
Subject: Re: [PATCH] Multiple timer issues + new [PATCH]

On 2/18/16 6:39 PM, Ir=C3=A1nyossy Knoblauch Art=C3=BAr wrote:
> The ntod timer (type hires_ns), however, is getting its time value
> from QueryPerformanceCounter(), which, according to the MSDN
> documentation, will provide a "time stamp that can be used for
> time-interval measurements" -- that is just what the doctor ordered.
> :-)

I have some interest in this because my work on select() may interact
with what you're doing here.

There's some information on the web discussing issues with
QueryPerformanceCounter(), for example
<http://www.virtualdub.org/blog/pivot/entry.php?id=3D106>.  This is mostly
an issue with CPUs available in the (I think) 2003-2006 time frame, such
as early AMD Athlons and early Intel Core iNNN and iNNNN CPUs.  Earlier
CPUs didn't have both changeable clock rates and RDTSC, and later CPUs
had RDTSC but the clock rate is constant for RDTSC.  It's also possible
that only some versions of Windows have issues in this area, maybe later
versions of Windows avoid this problem.  Does your code work properly in
this case?

regards,

  --jh
