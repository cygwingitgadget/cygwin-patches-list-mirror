Return-Path: <cygwin-patches-return-8003-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26119 invoked by alias); 20 Jun 2014 17:09:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26102 invoked by uid 89); 20 Jun 2014 17:09:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.5 required=5.0 tests=AWL,BAYES_00,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-HELO: etr-usa.com
Received: from etr-usa.com (HELO etr-usa.com) (130.94.180.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 20 Jun 2014 17:09:05 +0000
Received: (qmail 58180 invoked by uid 13447); 20 Jun 2014 17:09:03 -0000
Received: from unknown (HELO [172.20.0.42]) ([68.35.121.157])          (envelope-sender <warren@etr-usa.com>)          by 130.94.180.135 (qmail-ldap-1.03) with SMTP          for <cygwin-patches@cygwin.com>; 20 Jun 2014 17:09:03 -0000
Message-ID: <53A46AAE.3070403@etr-usa.com>
Date: Fri, 20 Jun 2014 17:09:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: /packages CGI HTML modernization
References: <53A30714.7010707@etr-usa.com> <87fvj0ur5y.fsf@Rainer.invalid> <53A4672C.9080304@etr-usa.com>
In-Reply-To: <53A4672C.9080304@etr-usa.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2014-q2/txt/msg00026.txt.bz2

On 6/20/2014 10:54, Warren Young wrote:
>
> The CSS is now:

Sorry, left a few things out:

   ul.pkglist li {
     display: block;
     clear: both;
   }

   ul.pkglist a {
     background: url('http://sourceware.org/icons/ball.gray.gif')
                 no-repeat;
     background-position: 0px 0.7em;
     background-size: 10px 10px;
     padding-left: 20px;
     padding-top: 0.4em;
     float: left;
     width: 30%;
   }

   ul.pkglist span {
     float: left;
     padding-top: 0.4em;
     width: 67%;
   }

The main thing is that I forgot to include the "ul.pkglist" parent 
qualifiers on the second two CSS rules.

Note, however, that I also added the width attributes to the two <li> 
children, which has the nice effect of making the JS completely 
optional.  The default values will make the package name column wrap, 
but if JS is available, the jQuery script I posted previously will 
increase the column width to fix that.

The (30%+67%) < 100% thing is another hack around the margins the 
browser uses, just like the 40px magic constant in the JS.
