<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_header.jsp" %>
<main id="user">
    <section class="terms">
        <table border="1">
            <caption>사이트 이용약관</caption>
            <tr>
                <td>
                <textarea name="terms">약관내용</textarea>
                <label><input type="checkbox" for="checkbox" class="terms">&nbsp;동의합니다.</label>
                </td>
            </tr>
        </table>
        <table border="1">
            <caption>개인정보 취급방침</caption>
            <tr>
                <td>
                <textarea name="privacy">약관내용</textarea>
                <label><input type="checkbox" for="checkbox" class="terms">&nbsp;동의합니다.</label>
                </td>
            </tr>
        </table>
        <p>
            <a href="/Jboard1/user/login.jsp" class="btn btnCancel">취소</a>
            <a href="/Jboard1/user/register.jsp" class="btn btnNext">다음</a>
        </p>
    </section>
</main>
<%@ include file="_footer.jsp" %>