Return-Path: <cygwin-patches-return-8002-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16737 invoked by alias); 20 Jun 2014 16:54:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16724 invoked by uid 89); 20 Jun 2014 16:54:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.5 required=5.0 tests=AWL,BAYES_00,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-HELO: etr-usa.com
Received: from etr-usa.com (HELO etr-usa.com) (130.94.180.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 20 Jun 2014 16:54:07 +0000
Received: (qmail 20990 invoked by uid 13447); 20 Jun 2014 16:54:05 -0000
Received: from unknown (HELO [172.20.0.42]) ([68.35.121.157])          (envelope-sender <warren@etr-usa.com>)          by 130.94.180.135 (qmail-ldap-1.03) with SMTP          for <cygwin-patches@cygwin.com>; 20 Jun 2014 16:54:05 -0000
Message-ID: <53A4672C.9080304@etr-usa.com>
Date: Fri, 20 Jun 2014 16:54:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: /packages CGI HTML modernization
References: <53A30714.7010707@etr-usa.com> <87fvj0ur5y.fsf@Rainer.invalid>
In-Reply-To: <87fvj0ur5y.fsf@Rainer.invalid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2014-q2/txt/msg00025.txt.bz2

On 6/19/2014 22:43, Achim Gratz wrote:

>    background-size: 1em 1em;

No.  The original gray ball bitmap is 20x20, and the current layout 
scales it to 10x10, on purpose.  Scaling it to "em"s makes the size 
font-dependent.

Ideally, cygwin.com would have its own bullet image so it doesn't have 
to be scaled in the browser.  The result wouldn't need to be padded, 
either, since CSS can take care of positioning and margins.

>     width: 30%;

You can do both, of course.  Set the width of the package name column to 
30% -- or whatever -- in the static CSS, so that at least you'll have a 
sensible default in the noscript case.

I do now see that the page already uses JavaScript.

On revisiting this, I've come up with several refinements, with the end 
result that the new concept fully replicates the existing look.

First, the <span> around the <a> is redundant.  You can address the 
package name link element directly.

Second, by putting the description in a span, you can make it wrap 
inside the second column width just as the current <table> based 
implementation does.

The second change makes the gray ball list bullet disappear for some 
reason if you leave it on the <li> element, but I figured out how to get 
it to appear as part of the <a> element.  It means the bullet is now 
clickable, which is odd, but this doesn't bother me.

Each <li> now looks like this:

     <li><a href="x86/pkg">pkg</a><span>description</span></li>

The CSS is now:

   <style type="text/css">
     ul.pkglist li {
       display: block;
       clear: both;
     }

     a {
       background: url('http://sourceware.org/icons/ball.gray.gif')
                   no-repeat;
       background-position: 0px 0.7em;
       background-size: 10px 10px;
       float: left;
       padding-left: 20px;
       padding-top: 0.4em;
     }

     span {
       float: left;
       padding-top: 0.4em;
     }
   </style>

and the JS is now:

     <script type="text/javascript">
       var lw = $('ul.pkglist').width();
       var mw = 0;
       $('ul.pkglist a').each(function(i, e) {
         mw = Math.max(mw, $(e).width());
       }).css('width', mw + 10 + 'px');
       $('ul.pkglist span').css('width', lw - mw - 40 + 'px');
     </script>

The "40" constant subtracts out some of the padding the browser adds. 
If it gets too small -- or you leave it out -- the <span> becomes too 
wide and has to wrap below the <a>.

I made these changes to a copy of the /packages generated HTML, and the 
page weight and render time both dropped roughly in half.
