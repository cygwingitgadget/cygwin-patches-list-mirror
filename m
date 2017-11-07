Return-Path: <cygwin-patches-return-8910-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 58140 invoked by alias); 7 Nov 2017 22:13:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 58129 invoked by uid 89); 7 Nov 2017 22:13:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-21.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=ham version=3.3.2 spammy=H*c:alternative, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail-it0-f43.google.com
Received: from mail-it0-f43.google.com (HELO mail-it0-f43.google.com) (209.85.214.43) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 07 Nov 2017 22:12:59 +0000
Received: by mail-it0-f43.google.com with SMTP id k70so7505088itk.0        for <cygwin-patches@cygwin.com>; Tue, 07 Nov 2017 14:12:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=HX+sS/0UTWrWuIlY+qk73+MIB90X71l71feH1G5N6HA=;        b=E2deLDJH8l3c0Oznn95Je3P7Nrk3Ud3C43Y5mQDOD8ZDm4NIB7uet7qWB/bnWNwNNq         1K119cNINCM6MLKDXsVVOajWvTvwlF4bEGoEFN0o6+oW+FaPbPyQEz6kQBIGJgQxoCfI         eCnHwE2tPifunRqjtMPb0uvAf1gmLusryha9YeZuiUpKaMzn4J86ZHsFqtkUnyQ8kOjn         6tZif260/9Dj9T3Sj9SKKdo0sYWYmpGBvDQ25+oB326wjRtqRPUOX2giFlUHba2D3ABF         B561UmrBMAO0I/LkcuRW2lNd7tsjxqnXDC4nq4HZTmHsWWNUlnXHM+OQCpiCzChU+nLM         aYrA==
X-Gm-Message-State: AJaThX7CjzgYAht0Zuik2HGFpAA+OLvWzjgnnMNHEIAwd3siSztBp/aK	smtSjWdnEKBKKaW21BBRcsOhYIzZQAIPuN7j3QZuRQ==
X-Google-Smtp-Source: ABhQp+T0gRfUUxy/kEU9rAken5TPXfgPZUD+FyxhxX79PPmJaOvHhHf6Z/lvkXKig3Ran+dcuriIB7FHujJ8c4g+1Uk=
X-Received: by 10.36.254.140 with SMTP id w134mr991785ith.73.1510092777710; Tue, 07 Nov 2017 14:12:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.105.204 with HTTP; Tue, 7 Nov 2017 14:12:56 -0800 (PST)
Received: by 10.2.105.204 with HTTP; Tue, 7 Nov 2017 14:12:56 -0800 (PST)
In-Reply-To: <20171107153643.GD14762@calimero.vinschen.de>
References: <20171107134449.11532-1-erik.m.bray@gmail.com> <20171107151134.GC14762@calimero.vinschen.de> <20171107153643.GD14762@calimero.vinschen.de>
From: Erik Bray <erik.m.bray@gmail.com>
Date: Tue, 07 Nov 2017 22:13:00 -0000
Message-ID: <CAOTD34aftOjyZA2YSjatg8n2PrBAM0J-zbkS4YR40bAOUdKpsQ@mail.gmail.com>
Subject: Re: [PATCH] Fix two bugs in the limit of large numbers of sockets:
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00040.txt.bz2

On Nov 7, 2017 16:36, "Corinna Vinschen" wrote:

Erik,

On Nov  7 16:11, Corinna Vinschen wrote:
> On Nov  7 14:44, Erik M. Bray wrote:
> > * Fix the maximum number of sockets allowed in the session to 2048,
> >   instead of making it relative to sizeof(wsa_event).
> >
> >   The original choice of 2048 was in order to fit the wsa_events array
> >   in the .cygwin_dll_common shared section, but there is still enough
> >   room to grow there to have 2048 sockets on 64-bit as well.
> >
> > * Return an error and set errno=ENOBUF if a socket can't be created
> >   due to this limit being reached.
> > ---
> >  winsup/cygwin/fhandler_socket.cc | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/winsup/cygwin/fhandler_socket.cc b/winsup/cygwin/fhandler_
socket.cc
> > index 7a6dbdc..b8eda57 100644
> > --- a/winsup/cygwin/fhandler_socket.cc
> > +++ b/winsup/cygwin/fhandler_socket.cc
> > @@ -496,7 +496,7 @@ fhandler_socket::af_local_set_secret (char *buf)
> >  /* Maximum number of concurrently opened sockets from all Cygwin
processes
> >     per session.  Note that shared sockets (through dup/fork/exec) are
> >     counted as one socket. */
> > -#define NUM_SOCKS       (32768 / sizeof (wsa_event))
> > +#define NUM_SOCKS       ((unsigned int) 2048)
> >
> >  #define LOCK_EVENTS        \
> >    if (wsock_mtx && \
> > @@ -623,7 +623,14 @@ fhandler_socket::init_events ()
> >        NtClose (wsock_mtx);
> >        return false;
> >      }
> > -  wsock_events = search_wsa_event_slot (new_serial_number);
> > +  if (!(wsock_events = search_wsa_event_slot (new_serial_number)));
                                                                      ^^^
did you actually test this?

https://sourceware.org/git/?p=newlib-cygwin.git;a=commitdiff;h=
2e989b212955665384bf61ee82dd487844a9371a


I mean, of course. I'm running a build right now with this fix (and have
since built on my branch with no problem). Maybe I somehow fat-fingered a
semicolon before committing, sorry.
