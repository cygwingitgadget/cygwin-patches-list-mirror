Return-Path: <cygwin-patches-return-7013-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19765 invoked by alias); 30 Mar 2010 16:36:12 -0000
Received: (qmail 19754 invoked by uid 22791); 30 Mar 2010 16:36:12 -0000
X-SWARE-Spam-Status: No, hits=-1.4 required=5.0 	tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SARE_MSGID_LONG40,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from fg-out-1718.google.com (HELO fg-out-1718.google.com) (72.14.220.159)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 30 Mar 2010 16:36:06 +0000
Received: by fg-out-1718.google.com with SMTP id d23so153728fga.2         for <cygwin-patches@cygwin.com>; Tue, 30 Mar 2010 09:36:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.239.145.79 with HTTP; Tue, 30 Mar 2010 09:36:02 -0700 (PDT)
In-Reply-To: <20100330161503.GB18364@calimero.vinschen.de>
References: <20091216145627.GM8059@calimero.vinschen.de> 	 <4B2C0715.8090108@towo.net> 	 <20091221101216.GA5632@calimero.vinschen.de> 	 <20100125190806.GA9166@calimero.vinschen.de> 	 <4B5F0585.9070903@towo.net> 	 <20100330095912.GZ18364@calimero.vinschen.de> 	 <4BB1D83A.8010406@towo.net> 	 <20100330142200.GA12926@calimero.vinschen.de> 	 <4BB21CBF.7030701@towo.net> 	 <20100330161503.GB18364@calimero.vinschen.de>
Date: Tue, 30 Mar 2010 16:36:00 -0000
Received: by 10.239.190.75 with SMTP id w11mr605796hbh.205.1269966962551; Tue,  	30 Mar 2010 09:36:02 -0700 (PDT)
Message-ID: <416096c61003300936i55764afeqf06d84251cd9a9b7@mail.gmail.com>
Subject: Re: console enhancements: mouse events etc
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
X-SW-Source: 2010-q1/txt/msg00129.txt.bz2

>=C2=A0How can I enforce printing garbage so I
> can test the reset command?

echo $'\e(0'
