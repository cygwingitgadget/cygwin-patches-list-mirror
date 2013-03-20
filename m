Return-Path: <cygwin-patches-return-7858-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29849 invoked by alias); 20 Mar 2013 06:22:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29836 invoked by uid 89); 20 Mar 2013 06:22:28 -0000
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1
Received: from mail-la0-f43.google.com (HELO mail-la0-f43.google.com) (209.85.215.43)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Wed, 20 Mar 2013 06:22:26 +0000
Received: by mail-la0-f43.google.com with SMTP id ek20so2476606lab.16        for <cygwin-patches@cygwin.com>; Tue, 19 Mar 2013 23:22:23 -0700 (PDT)
X-Received: by 10.112.103.67 with SMTP id fu3mr9135017lbb.46.1363760543772; Tue, 19 Mar 2013 23:22:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.12.99 with HTTP; Tue, 19 Mar 2013 23:22:03 -0700 (PDT)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
Date: Wed, 20 Mar 2013 06:22:00 -0000
Message-ID: <CAGvSfexvjDhbp7sJvoKpF_GYt9t2DmuCD7QmdmFkzdA4=GBeTA@mail.gmail.com>
Subject: [PATCH 64bit] Fix ONDEE for 64bit, part 2
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=f46d0401fabbc53d0a04d8553eed
X-SW-Source: 2013-q1/txt/msg00069.txt.bz2


--f46d0401fabbc53d0a04d8553eed
Content-Type: text/plain; charset=ISO-8859-1
Content-length: 97

Unfortunately I missed something last time when I tried fixing ONDEE.
Patch attached.

--
Yaakov

--f46d0401fabbc53d0a04d8553eed
Content-Type: application/octet-stream; 
	name="cygwin-ondee-64bit-part2.patch"
Content-Disposition: attachment; filename="cygwin-ondee-64bit-part2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hei3skl90
Content-length: 3099

MjAxMy0wMy0yMCAgWWFha292IFNlbGtvd2l0eiAgPHlzZWxrb3dpdHpALi4u
PgoKCSogbGliL19jeWd3aW5fY3J0MF9jb21tb24uY2M6IEZpeCBtYW5nbGVk
IG9wZXJhdG9yIG5ldyBuYW1lcyBmb3IgeDg2XzY0LgoKSW5kZXg6IGxpYi9f
Y3lnd2luX2NydDBfY29tbW9uLmNjCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
UkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2xpYi9fY3ln
d2luX2NydDBfY29tbW9uLmNjLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjI0
LjIuNApkaWZmIC11IC1wIC1yMS4yNC4yLjQgX2N5Z3dpbl9jcnQwX2NvbW1v
bi5jYwotLS0gbGliL19jeWd3aW5fY3J0MF9jb21tb24uY2MJNSBNYXIgMjAx
MyAxNDoyOTozMCAtMDAwMAkxLjI0LjIuNAorKysgbGliL19jeWd3aW5fY3J0
MF9jb21tb24uY2MJMjAgTWFyIDIwMTMgMDY6MTc6MzYgLTAwMDAKQEAgLTE3
LDIyICsxNywzNCBAQCBkZXRhaWxzLiAqLwogICAgdW5uZWNlc3NhcmlseS4g
ICovCiAjZGVmaW5lIFdFQUsgX19hdHRyaWJ1dGVfXyAoKHdlYWspKQogCisj
aWZkZWYgX194ODZfNjRfXworI2RlZmluZSBSRUFMX1pOV1gJCSJfX3JlYWxf
X1pud20iCisjZGVmaW5lIFJFQUxfWk5BWAkJIl9fcmVhbF9fWm5hbSIKKyNk
ZWZpbmUgUkVBTF9aTldYX05PVEhST1dfVAkiX19yZWFsX19abndtUktTdDlu
b3Rocm93X3QiCisjZGVmaW5lIFJFQUxfWk5BWF9OT1RIUk9XX1QJIl9fcmVh
bF9fWm5hbVJLU3Q5bm90aHJvd190IgorI2Vsc2UKKyNkZWZpbmUgUkVBTF9a
TldYCQkiX19fcmVhbF9fWm53aiIKKyNkZWZpbmUgUkVBTF9aTkFYCQkiX19f
cmVhbF9fWm5haiIKKyNkZWZpbmUgUkVBTF9aTldYX05PVEhST1dfVAkiX19f
cmVhbF9fWm53alJLU3Q5bm90aHJvd190IgorI2RlZmluZSBSRUFMX1pOQVhf
Tk9USFJPV19UCSJfX19yZWFsX19abmFqUktTdDlub3Rocm93X3QiCisjZW5k
aWYKKwogLyogVXNlIGFzbSBuYW1lcyB0byBieXBhc3MgdGhlIC0td3JhcCB0
aGF0IGlzIGJlaW5nIGFwcGxpZWQgdG8gcmVkaXJlY3QgYWxsIG90aGVyCiAg
ICByZWZlcmVuY2VzIHRvIHRoZXNlIG9wZXJhdG9ycyB0b3dhcmQgdGhlIHJl
ZGlyZWN0b3JzIGluIHRoZSBDeWd3aW4gRExMOyB0aGlzCiAgICB3YXkgd2Ug
Y2FuIHJlY29yZCB3aGF0IGRlZmluaXRpb25zIHdlcmUgdmlzaWJsZSBhdCBm
aW5hbCBsaW5rIHRpbWUgYnV0IHN0aWxsCiAgICBzZW5kIGFsbCBjYWxscyB0
byB0aGUgcmVkaXJlY3RvcnMuICAqLwogZXh0ZXJuIFdFQUsgdm9pZCAqb3Bl
cmF0b3IgbmV3KHN0ZDo6c2l6ZV90IHN6KSB0aHJvdyAoc3RkOjpiYWRfYWxs
b2MpCi0JCQlfX2FzbV9fIChfU1lNU1RSIChfX3JlYWxfX1pud2opKTsKKwkJ
CV9fYXNtX18gKFJFQUxfWk5XWCk7CiBleHRlcm4gV0VBSyB2b2lkICpvcGVy
YXRvciBuZXdbXShzdGQ6OnNpemVfdCBzeikgdGhyb3cgKHN0ZDo6YmFkX2Fs
bG9jKQotCQkJX19hc21fXyAoX1NZTVNUUiAoX19yZWFsX19abmFqKSk7CisJ
CQlfX2FzbV9fIChSRUFMX1pOQVgpOwogZXh0ZXJuIFdFQUsgdm9pZCBvcGVy
YXRvciBkZWxldGUodm9pZCAqcCkgdGhyb3coKQogCQkJX19hc21fXyAoX1NZ
TVNUUiAoX19yZWFsX19aZGxQdiApKTsKIGV4dGVybiBXRUFLIHZvaWQgb3Bl
cmF0b3IgZGVsZXRlW10odm9pZCAqcCkgdGhyb3coKQogCQkJX19hc21fXyAo
X1NZTVNUUiAoX19yZWFsX19aZGFQdikpOwogZXh0ZXJuIFdFQUsgdm9pZCAq
b3BlcmF0b3IgbmV3KHN0ZDo6c2l6ZV90IHN6LCBjb25zdCBzdGQ6Om5vdGhy
b3dfdCAmbnQpIHRocm93KCkKLQkJCV9fYXNtX18gKF9TWU1TVFIgKF9fcmVh
bF9fWm53alJLU3Q5bm90aHJvd190KSk7CisJCQlfX2FzbV9fIChSRUFMX1pO
V1hfTk9USFJPV19UKTsKIGV4dGVybiBXRUFLIHZvaWQgKm9wZXJhdG9yIG5l
d1tdKHN0ZDo6c2l6ZV90IHN6LCBjb25zdCBzdGQ6Om5vdGhyb3dfdCAmbnQp
IHRocm93KCkKLQkJCV9fYXNtX18gKF9TWU1TVFIgKF9fcmVhbF9fWm5halJL
U3Q5bm90aHJvd190KSk7CisJCQlfX2FzbV9fIChSRUFMX1pOQVhfTk9USFJP
V19UKTsKIGV4dGVybiBXRUFLIHZvaWQgb3BlcmF0b3IgZGVsZXRlKHZvaWQg
KnAsIGNvbnN0IHN0ZDo6bm90aHJvd190ICZudCkgdGhyb3coKQogCQkJX19h
c21fXyAoX1NZTVNUUiAoX19yZWFsX19aZGxQdlJLU3Q5bm90aHJvd190KSk7
CiBleHRlcm4gV0VBSyB2b2lkIG9wZXJhdG9yIGRlbGV0ZVtdKHZvaWQgKnAs
IGNvbnN0IHN0ZDo6bm90aHJvd190ICZudCkgdGhyb3coKQo=

--f46d0401fabbc53d0a04d8553eed--
