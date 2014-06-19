Return-Path: <cygwin-patches-return-8000-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15515 invoked by alias); 19 Jun 2014 15:51:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15502 invoked by uid 89); 19 Jun 2014 15:51:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_05,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-HELO: etr-usa.com
Received: from etr-usa.com (HELO etr-usa.com) (130.94.180.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 19 Jun 2014 15:51:50 +0000
Received: (qmail 37266 invoked by uid 13447); 19 Jun 2014 15:51:49 -0000
Received: from unknown (HELO [172.20.0.42]) ([68.35.121.157])          (envelope-sender <warren@etr-usa.com>)          by 130.94.180.135 (qmail-ldap-1.03) with SMTP          for <cygwin-patches@cygwin.com>; 19 Jun 2014 15:51:49 -0000
Message-ID: <53A30714.7010707@etr-usa.com>
Date: Thu, 19 Jun 2014 15:51:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: /packages CGI HTML modernization
Content-Type: multipart/mixed; boundary="------------040706060509020502010204"
X-IsSubscribed: yes
X-SW-Source: 2014-q2/txt/msg00023.txt.bz2

This is a multi-part message in MIME format.
--------------040706060509020502010204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1434

The current CGI code that generates the package and file lists for 
http://cygwin.com/packages emits highly redundant HTML, and it is laid 
out using a huge slow-to-render table.  The attached patch shows a 
minimal way to use <ul> instead of <table>, along with some CSS and JS 
to style it in a similar way to the current look.

If JavaScript is verboten on cygwin.com, you can empirically find an 
appropriate value for the width of the package name column and put that 
in the CSS:

     ul.pkglist span {
         float: left;
         width: 185px;
     }

All the jQuery code does is find that width value programmatically, 
which makes it robust in the face of different font sizes and such.

I have also attached a simple example HTML and CSS file, which show the 
basic idea of the change with all the distractions of the real /packages 
page stripped away.  Just put packages.* in a directory and open 
packages.html in your favorite browser.

I lack the ability to generate packages.inc here, but I expect applying 
the same concept to that script as well will have a measurable effect on 
the load time of cygwin.com/packages.  I expect it to roughly halve the 
size of the file and measurably reduce the page render time.

The contents of the attached CSS file should be inserted into one of 
cygwin.com's normal CSS files.

(I've attached all this as a tarball only to placate the text/html MIME 
filter on this list.)

--------------040706060509020502010204
Content-Type: application/octet-stream;
 name="pg-html5.tar.xz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="pg-html5.tar.xz"
Content-length: 1749

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj4Cf/BMddADgZwaUaWSNvNFbBNv0N
SG7sjOYAX3nnKu1IoIgcjzOa3SAaStJBqcy7gw9WIb4HbEd5OGQknJKornOM
VK6CEfUoQTa0Dtr5WY09N5etl2XNITzHKSvuCWl7G4PD2MNOfPD6I+8BUF7U
c2oxDM+AyRSE3pY3Q0H6j9cZDPbABgkjTF9vDwB8b5Mf8bY2aqlrkzCMVnq+
+TOF9i1Sun2GmNF8ACYS6DvjFgyW2Ip3TJVURZvsamDFVT4rNkFrr6PtEIXS
7a7+cL3q9oOdwkBvwQwQUgQ12xXc4/gkjkH1fXMJwfMZ6ZqQSbjmyIowIs/k
a3MdX8sKHl4Ws8ETq5dYn4Z2aTz3ZKiCLTjDhrI0lMLfq9a/xGbT5nX/WWPK
fKioCJc917T11Zd5Nq+dD5822DWeDzkN2zo/K57adBkta824HeHNFvwPPT7n
FHKyjPMFM+UKTTY+J0DM6Yq8xI9DqnzqTWaljQlI0K9V7/9KvllUl/oJINvk
P2Qu2/Y8o1czBePN7Kl4XRp0KkLbUD2Pc6EBA6CbEADvXLpwIx8Nj3QDfOmR
BDRST8SGwRZrrcNjFb32btza2YlsdsYgOc6cPcCcGbGgmVISL+BZmhbBvKTC
5F6l6rifU/gK4IMNehnMBqBtm9dtyTwnAG0AfFeD8bMwsvkKRXK2jJy6zobH
a0VSqIqUI6FHy33IRAeet6V9tyHmOi3mfj1ZiQOmLD5UBDWIXzwkjzOytIDs
7SCNWvMhHF1NaMYqETWTzKFKeF21LKVCs8OXtVbqJCbA815OHh/n3diVNFJc
u4Gk/mE3PjMfDuMbIMHCNgZ5v4b3ct8GBseJZziA32cGwoPaalB9L1aYz503
AsEhuKw4/YW4ltrlfwRGj6j9TfNqubOSWN+ZXhiLyLapVGAainRB3CGhHJUW
hsUG7Km+2FhijAec6/ngFyy1T+COCUkv+a8jkOejonXyZJFaSockLfXCcjc/
gdGU25Vp23tKwWmkDnekT+ZnBWfKUCu7mTEHOCsrlI8PYKpaOYSm1zZc2Yvq
iWbxFWmtVXGUBRnwgAJuBYnM0G2Fyx0GSL6rW2H9Vz8hlDr6I2MiQcbE2U15
E8u2/LFhLIUCmLAKGPtN9Njo+k2GMcePFXL/NJE94nkVM4cqyhZUFFpmLcal
DVTQw+qW1sxnqgV9LMX6Ldi4s4mhdpuuGLSycIKKkf4N9kxoge70x22dK+OG
9SWYY1TnXphJAWH+3Ku3HzQ4DPDDFkT1q58+U3H+THHMbYcF5qtkMA29k355
resTmPgm0rMF8OXYRXzDcY9/raqr5stRCzR7PAHC1cZDKyPlbvGDKWGeTFmI
nxpoKdhCwm9zXJAcsxszv2tBH4Jj+f1dxw+ZHPxqjU7PJBqldCtT+TPXGKSM
rxIcuhkaHTGBHi/JcW4srWgGu/HGMemgxUbKsg9EpPiiVcRV1pRSGMscUTMI
7jxf0jdRZ02Dq/7SvG0m7v/ycNNCz/xOgTY4axu+cMa8hN6FH2tIqx22RtIH
zS3lwmodenEkKtKA9KHjishshLXiOxhDWpGZXBKPhEHR75mPsAHM3hozNsba
hDLcOdIlzjKR8EfqXK7Ly5eQwYOhP1/FjUCQXq9ksGLI3QIHvySAAADLBgaM
OgyQywAB4wmAUAAAC0dw37HEZ/sCAAAAAARZWg==

--------------040706060509020502010204--
