Return-Path: <cygwin-patches-return-8001-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16333 invoked by alias); 20 Jun 2014 04:43:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16317 invoked by uid 89); 20 Jun 2014 04:43:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-in-02.arcor-online.net
Received: from mail-in-02.arcor-online.net (HELO mail-in-02.arcor-online.net) (151.189.21.42) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (CAMELLIA256-SHA encrypted) ESMTPS; Fri, 20 Jun 2014 04:43:41 +0000
Received: from mail-in-17-z2.arcor-online.net (mail-in-17-z2.arcor-online.net [151.189.8.34])	by mx.arcor.de (Postfix) with ESMTP id B65A9300FD	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2014 06:43:38 +0200 (CEST)
Received: from mail-in-18.arcor-online.net (mail-in-18.arcor-online.net [151.189.21.58])	by mail-in-17-z2.arcor-online.net (Postfix) with ESMTP id B40A0366111	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2014 06:43:38 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-18.arcor-online.net 9B34C3DC30E
Received: from Rainer.invalid (pD9EB3536.dip0.t-ipconnect.de [217.235.53.54])	(Authenticated sender: stromeko@arcor.de)	by mail-in-18.arcor-online.net (Postfix) with ESMTPSA id 9B34C3DC30E	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2014 06:43:38 +0200 (CEST)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: /packages CGI HTML modernization
References: <53A30714.7010707@etr-usa.com>
Date: Fri, 20 Jun 2014 04:43:00 -0000
In-Reply-To: <53A30714.7010707@etr-usa.com> (Warren Young's message of "Thu,	19 Jun 2014 09:51:48 -0600")
Message-ID: <87fvj0ur5y.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2014-q2/txt/msg00024.txt.bz2

Warren Young writes:
> The current CGI code that generates the package and file lists for
> http://cygwin.com/packages emits highly redundant HTML, and it is laid
> out using a huge slow-to-render table.  The attached patch shows a
> minimal way to use <ul> instead of <table>, along with some CSS and JS
> to style it in a similar way to the current look.

+1

> If JavaScript is verboten on cygwin.com, you can empirically find an
> appropriate value for the width of the package name column and put
> that in the CSS:
>
>     ul.pkglist span {
>         float: left;
>         width: 185px;
>     }

I'd try something like this to keep it more nicely scalable:

ul.pkglist li {
   background: url('http://sourceware.org/icons/ball.gray.gif')
   no-repeat center left 0.2em;
   background-size: 1em 1em;
   padding-left: 1.4em;
   display: block;
   align: center;
}

ul.pkglist span {
   float: left;
   width: 30%;
}


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf rackAttack:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds
