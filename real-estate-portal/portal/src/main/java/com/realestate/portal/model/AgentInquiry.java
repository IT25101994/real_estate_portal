package com.realestate.portal.model;

/**
 * MEMBER 3 — AgentInquiry (Subclass)
 * Represents an agent's perspective on an inquiry.
 */
public class AgentInquiry extends Inquiry {

    private String responseDate;
    private String agentNotes;

    public AgentInquiry() { super(); }

    public String getResponseDate()               { return responseDate; }
    public void   setResponseDate(String date)    { this.responseDate = date; }
    public String getAgentNotes()                 { return agentNotes; }
    public void   setAgentNotes(String notes)     { this.agentNotes = notes; }

    @Override
    public String getStatusLabel() {
        if ("responded".equals(getStatus()) && responseDate != null)
            return "Responded on " + responseDate;
        return super.getStatusLabel();
    }
}
