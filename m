Return-Path: <cygwin-patches-return-9298-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 35581 invoked by alias); 3 Apr 2019 09:18:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35572 invoked by uid 89); 3 Apr 2019 09:18:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=H*RU:sk:michael, H*r:sk:michael, HX-Spam-Relays-External:sk:michael
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 03 Apr 2019 09:18:39 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 11:18:35 +0200
Received: from [172.28.53.54]	by mailhost.salomon.at with esmtps (UNKNOWN:AES128-SHA:128)	(Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hBc2U-0003Bb-JU; Wed, 03 Apr 2019 11:18:34 +0200
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
References: <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <20190327091640.GE4096@calimero.vinschen.de> <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com> <678d8ec4-f6c2-1538-aafd-dbb9cfc5dea5@ssi-schaefer.com> <20190328095818.GP4096@calimero.vinschen.de> <fd7b9ab3-ca07-0c80-04da-4f6b2f20d49e@ssi-schaefer.com> <20190328203056.GB4096@calimero.vinschen.de> <fe627231-6717-c702-b97b-d66cdc9409a3@ssi-schaefer.com> <20190401145658.GA6331@calimero.vinschen.de> <20190401155636.GN3337@calimero.vinschen.de>
To: cygwin-patches@cygwin.com
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <837bc171-eb6f-681e-5167-103f5e9e8523@ssi-schaefer.com>
Date: Wed, 03 Apr 2019 09:18:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401155636.GN3337@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------80420478EF5EB6349948640C"
X-SW-Source: 2019-q2/txt/msg00005.txt.bz2

This is a multi-part message in MIME format.
--------------80420478EF5EB6349948640C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 1073

On 4/1/19 5:56 PM, Corinna Vinschen wrote:
> On Apr  1 16:56, Corinna Vinschen wrote:
>> On Apr  1 16:28, Michael Haubenwallner wrote:
>>> On 3/28/19 9:30 PM, Corinna Vinschen wrote:
>>>> can you please collect the base addresses of all DLLs generated during
>>>> the build, plus their size and make a sorted list?  It would be
>>>> interesting to know if the hash algorithm in ld is actually as bad
>>>> as I conjecture.
>>>
>>> Please find attached the output of rebase -i for the dlls after bootstrap
>>> on Cygwin 3.0.4, each built with ld from binutils-2.31.1.
> 
> Oh, wait.  That's not what I was looking for.  The addresses are ok, but
> the paths *must* be the ones at the time the DLLs have been created,
> because that's what ld uses when creating the image base addresses.  The
> addresses combined with the installation paths don't make sense anymore.

So I have intercepted the ld.exe to show 'rebase -i' on any just created dll,
tell about the exact -o argument to ld, and the current directory.

This is with binutils-2.31.1

Anything else needed?

/haubi/

--------------80420478EF5EB6349948640C
Content-Type: application/x-xz;
 name="dll-info.txt.xz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dll-info.txt.xz"
Content-length: 8345

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj4WxcF8pdABeaCeb5lQxnase/fMU8
yO6fvf1GDVK443YWW5XNOcU1H1gKCxKtZC1s0cZbAtTWr1V3cwD1xtx+nQiQ
eBcZC2B7lMgcjVLPLna7ZR+mt8rTgleLQckO4sGnyBWYN2mmFaFUfRZlugJW
//WfbKPSXeBYd4ghn8AUhE3ZFbzzmJccCxSJK4S3EwiXdvsI2JBHXrzy4B5g
m+ljixHZiyH0I1RbtVrF7GXfTvGxkU9S5a5tqO+YipuFO6rlWLGDfy8MM/FH
uWmQH93WBg6PbHj3RiK32IZBrK6HjPMi+5ePr7NQ1yjDGH1gIwFdV8Dofzdg
bOBVRSOsExc1j/Ii5KMWWj/5V4hK7+xRC+X3gA5DWDSeD0+3XuCloLbK0qRh
XmO6Tldg9UHy24v2MRBN/VkXrV8VvJNovYp53JPkwAKCk8zTZChcy53AoEr+
YDoPyO+aU596Y6ZVzAiYevv5tS4MoKfPb8z0E5FbI/ra7JRKIdi+Hjb0cNdh
XSzi8wittNEmVNyI90PK1sED2ovH07Iyeby3e7zvfgNT/hpvFO3XWrKRp20N
caIcIqPEt4i+/6o3q/Ahuhq0P9+jlOe6ijkt68FEImSr6CJeEuN8EADntpNZ
UFdrEd9wNy4dCXvhuv9uY5WldpDozdDBT6y8OftKtM73HVZuCA8odz5tQYOL
h5pKISOBE01vkCpTq3/Thl8HGqa6mX+NUiZ11JbCR/iR9dUxU/HtF9C9XhSw
Qcrrmaj80jf+piaX1zmw5m0C+zfCG4+RCkULL8ExKQ55qm20S3IkmHPj3lgB
BidNHdeAdxPa8lqdbcF0y4mQhVudc3S0LldWv7hGhP/WQLYrTOo7HchkZ17+
3A1oPxZ2jUmrJPmt7b/zqeeWxZSRaHD0/pGTKl+vZpQa5eDnhjfvaC4XOWbm
GcgZBinhHqBf4khyAMQv1D3+cIIWN05+g9qQUoqza8rqYX5GMUZPE3VEOvDG
Ejr7Y8tC7vfAEx3e+2wrjGck56Em2Cr9q4uFbe4SpwQW6Y5G9Dc64m0NOcG1
Clnsyd+1Bgjs/Qg611jNmYqsVymXfOQ4ZUu24FseJYl5B/Y4MiHJsl+gimfk
a+QlqRgwopk6f/R/kam6p2u1ynbr9OJzOGPUlbCIeYeodqe+VVeYZs/023Hh
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

--------------80420478EF5EB6349948640C--
