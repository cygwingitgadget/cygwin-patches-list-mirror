Return-Path: <cygwin-patches-return-4298-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6292 invoked by alias); 15 Oct 2003 06:50:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6282 invoked from network); 15 Oct 2003 06:50:09 -0000
Message-ID: <3F8CEE21.9080806@student.tue.nl>
Date: Wed, 15 Oct 2003 06:50:00 -0000
From: Micha Nelissen <M.Nelissen@student.tue.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20030924 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch]: Ncurses frame drawing
References: <3.0.5.32.20031014231622.0082c1b0@incoming.verizon.net>
In-Reply-To: <3.0.5.32.20031014231622.0082c1b0@incoming.verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q4/txt/msg00017.txt.bz2

Pierre A. Humblet wrote:

> At 10:26 PM 10/14/2003 +0200, Micha Nelissen wrote:
> 
>>@@ -1110,6 +1117,12 @@
>>	       break;
>>	     case 9:    /* dim */
>>	       dev_state->intensity = INTENSITY_DIM;
>>+	       break;
>>+             case 10:   /* end alternate charset */
>>+               alternate_charset_active = FALSE;
>>+	       break;
>>+             case 11:   /* start alternate charset */
>>+               alternate_charset_active = TRUE;
>>	       break;
>>	     case 24:
>>	       dev_state->underline = FALSE;
> 
> 
> FWIW, wouldn't it be cleaner to make "alternate_charset_active" a 
> member of dev_state instead of introducing a new global variable?

Yes, although original_codepage was a viable candidate for a global 
variable?. Never mind, but then either:
1) that alternate_charset check which currently is in str_to_con 
(centralized), needs to dispersed over all calls to str_to_con. 
(Currently, 1, AFAICS). Prone to bugs, if you ask me because this could 
be forgotten in the future, unless this one call will remain the only one.
2) str_to_con has to become a member of dev_state too.

Regards,

Micha.

