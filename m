Return-Path: <cygwin-patches-return-8318-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 91068 invoked by alias); 14 Feb 2016 12:29:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 89212 invoked by uid 89); 14 Feb 2016 12:29:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.7 required=5.0 tests=AWL,BAYES_40,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2 spammy=hood, 201412, Console, 14022016
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Sun, 14 Feb 2016 12:29:11 +0000
Received: from [192.168.178.44] ([95.91.214.87]) by mrelayeu.kundenserver.de (mreue001) with ESMTPSA (Nemesis) id 0Lf3PM-1aBEB12Gpk-00omMh for <cygwin-patches@cygwin.com>; Sun, 14 Feb 2016 13:29:07 +0100
Subject: Re: Cygwin select() issues and improvements
To: cygwin-patches@cygwin.com
References: <56C03624.1030703@glup.org>
From: Thomas Wolff <towo@towo.net>
Message-ID: <56C07316.8070001@towo.net>
Date: Sun, 14 Feb 2016 12:29:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <56C03624.1030703@glup.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-UI-Out-Filterresults: notjunk:1;V01:K0:EX+ASm/283Q=:2QR4QJJbylsnoEN/x6zFTt /CdbFLuqUa5/3i8uJcVJ5D04rYSo3OvMmnBJhIBJHnN8U+Gm7PMRf3rfQedemwvYZOjNSucwC qeAW0IVn1FKxb28NKrlCjOoBe21ERVnWIrbOgoRRbDFVbox8WguhP6rBAfRdikUHoIvuaUnXl V7dsW0QOFHG4r+6o6TO1DLZrbvxP1oZ7+6PdlvJ/1pGy5Tl3/q/y+nFyQaEHR1c12R2d4/jcl 1Rd0cXIYehES8ofvREgvCU9DiRUhvBbZ8qpl92858i4lWmYzhnG6wPlTSWrkD2gHdtITYpqWq Ms+Deqz6qqiryRp3oen8Pfrj6StuD5tv7f60kckm/vv/+iLiikV7AY3Xw+flh1qvA1HIyO2AP 8HhDqE+QDbEYaHy0DpgEsxYa0mrG4y+6B0LSpMDjx0Ir8EZYPs2atds12nWCZbXBXgmJ4NqBu cBBZT/uf8Er7g0iifxtRAeou+060BkidALHVgJ6MxjTi8+4qdXYYHhg5AeYqMu6HfxXennrst AauzFPnAcg0lSnXl3j6wTgN9CAz9Te3hslLxM8g4EVrpKYA73UQa+DtfNkRRUcaoPKNUiHCCY ayqvRTCI6gVF8pZeGzQLTsYj7Xpm2Ukpnr5AzrE71LEPxkCAC4bGnAcSvZ7SL5vTCEyPXqBVv W5k4XQkgpBku4kHfWsxS2X5jhEMS0XUVOnuOI6jOYXaWx5AvRaWMfP0usC4clKf/jfD5LaLKN Z/O5GSrRTs4UkQ4G
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00024.txt.bz2

Am 14.02.2016 um 09:09 schrieb john hood:
> [I Originally sent this last week, but it bounced.]
>
> Various issues with Cygwin's select() annoyed me, and I've spent some
> time gnawing on them.
>
> * With 1-byte reads, select() on Windows Console input would forget
> about unread input data stored in the fhandler's readahead buffer.
> Hitting F1 would send only the first ESC character, until you released
> the key and another Windows event was generated.  (one-line fix, though
> I'm not sure it's appropriate/correct)
>
> * ...
If that also solves the UTF-8 byte splitting problem 
https://cygwin.com/ml/cygwin/2014-12/msg00118.html that would be great, 
see test program attached there.
Thomas
